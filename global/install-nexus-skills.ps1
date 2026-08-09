[CmdletBinding()]
param(
    [ValidateSet('Priority', 'All')]
    [string]$Scope = 'Priority',

    [string]$SkillsDir = (Join-Path $HOME '.claude\skills'),

    [switch]$VerifyOnly
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$PrioritySkills = @(
    'nexus-godmode-master',
    'token-optimizer-v2',
    'project-memory-continuity',
    'security-guardian',
    'verification-before-completion',
    'git-guardrails-claude-code'
)

$RepoRoot = Split-Path -Parent $PSScriptRoot
$CanonicalSkillsDir = Join-Path $RepoRoot 'plugins\nexus-godmode-studio\skills'
$ReportPath = Join-Path $SkillsDir 'NEXUS-SKILL-VERIFICATION.md'
$Timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$BackupRoot = Join-Path $SkillsDir ".nexus-backup\$Timestamp"

function Get-RelativeFileHashes {
    param([Parameter(Mandatory)][string]$Root)

    if (-not (Test-Path -LiteralPath $Root -PathType Container)) {
        return @{}
    }

    $map = @{}
    Get-ChildItem -LiteralPath $Root -Recurse -File | ForEach-Object {
        $relative = [System.IO.Path]::GetRelativePath($Root, $_.FullName).Replace('\\', '/')
        $map[$relative] = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash
    }
    return $map
}

function Test-TreesEqual {
    param(
        [Parameter(Mandatory)][string]$Source,
        [Parameter(Mandatory)][string]$Target
    )

    $sourceHashes = Get-RelativeFileHashes -Root $Source
    $targetHashes = Get-RelativeFileHashes -Root $Target

    if ($sourceHashes.Count -ne $targetHashes.Count) {
        return $false
    }

    foreach ($key in $sourceHashes.Keys) {
        if (-not $targetHashes.ContainsKey($key)) { return $false }
        if ($targetHashes[$key] -ne $sourceHashes[$key]) { return $false }
    }

    return $true
}

function Get-DeclaredSkillName {
    param([Parameter(Mandatory)][string]$SkillFile)

    $content = Get-Content -LiteralPath $SkillFile -Raw
    $match = [regex]::Match($content, '(?m)^name:\s*["'']?([^\r\n"'']+)')
    if ($match.Success) {
        return $match.Groups[1].Value.Trim()
    }

    return (Split-Path -Leaf (Split-Path -Parent $SkillFile))
}

if (-not (Test-Path -LiteralPath $CanonicalSkillsDir -PathType Container)) {
    throw "Canonical NEXUS skills directory was not found: $CanonicalSkillsDir"
}

$AllSkills = Get-ChildItem -LiteralPath $CanonicalSkillsDir -Directory |
    Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') } |
    Select-Object -ExpandProperty Name |
    Sort-Object -Unique

$SelectedSkills = if ($Scope -eq 'All') { @($AllSkills) } else { @($PrioritySkills) }

$missingSource = @($SelectedSkills | Where-Object {
    -not (Test-Path -LiteralPath (Join-Path (Join-Path $CanonicalSkillsDir $_) 'SKILL.md') -PathType Leaf)
})
if ($missingSource.Count -gt 0) {
    throw "Missing canonical SKILL.md for: $($missingSource -join ', ')"
}

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null

$BeforeTopLevel = @(Get-ChildItem -LiteralPath $SkillsDir -Directory -Force | Select-Object -ExpandProperty Name)
$Installed = New-Object System.Collections.Generic.List[string]
$Updated = New-Object System.Collections.Generic.List[string]
$Verified = New-Object System.Collections.Generic.List[string]
$Failures = New-Object System.Collections.Generic.List[string]

if (-not $VerifyOnly) {
    foreach ($skill in $SelectedSkills) {
        $source = Join-Path $CanonicalSkillsDir $skill
        $target = Join-Path $SkillsDir $skill
        $existed = Test-Path -LiteralPath $target

        if ($existed) {
            $backup = Join-Path $BackupRoot $skill
            New-Item -ItemType Directory -Force -Path (Split-Path -Parent $backup) | Out-Null

            $item = Get-Item -LiteralPath $target -Force
            if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
                $linkInfo = Join-Path $BackupRoot "$skill.link.txt"
                New-Item -ItemType Directory -Force -Path $BackupRoot | Out-Null
                "Existing reparse-point target replaced during NEXUS skill sync: $target" | Set-Content -LiteralPath $linkInfo -Encoding UTF8
            }
            else {
                Copy-Item -LiteralPath $target -Destination $backup -Recurse -Force
            }

            Remove-Item -LiteralPath $target -Recurse -Force
        }

        Copy-Item -LiteralPath $source -Destination $target -Recurse -Force

        if (Test-TreesEqual -Source $source -Target $target) {
            if ($existed) { $Updated.Add($skill) } else { $Installed.Add($skill) }
        }
        else {
            $Failures.Add("$skill did not match its canonical source after copy")
        }
    }
}

foreach ($skill in $SelectedSkills) {
    $source = Join-Path $CanonicalSkillsDir $skill
    $target = Join-Path $SkillsDir $skill
    $skillFile = Join-Path $target 'SKILL.md'

    if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
        $Failures.Add("$skill is missing from $SkillsDir")
        continue
    }

    if (-not (Test-TreesEqual -Source $source -Target $target)) {
        $Failures.Add("$skill differs from the canonical NEXUS copy")
        continue
    }

    $Verified.Add($skill)
}

# Detect multiple SKILL.md manifests that claim one of the selected skill names.
$ManifestRecords = @()
Get-ChildItem -LiteralPath $SkillsDir -Recurse -File -Filter 'SKILL.md' -ErrorAction SilentlyContinue | ForEach-Object {
    $ManifestRecords += [pscustomobject]@{
        DeclaredName = Get-DeclaredSkillName -SkillFile $_.FullName
        FolderName   = Split-Path -Leaf $_.DirectoryName
        Path         = $_.FullName
    }
}

$DuplicateDetails = New-Object System.Collections.Generic.List[string]
foreach ($skill in $SelectedSkills) {
    $matches = @($ManifestRecords | Where-Object { $_.DeclaredName -eq $skill -or $_.FolderName -eq $skill })
    if ($matches.Count -gt 1) {
        $paths = ($matches | Select-Object -ExpandProperty Path) -join '; '
        $DuplicateDetails.Add("$skill => $paths")
        $Failures.Add("duplicate manifests detected for $skill")
    }
}

# Guardrail: installing/updating NEXUS skills must never remove unrelated existing top-level skills.
$AfterTopLevel = @(Get-ChildItem -LiteralPath $SkillsDir -Directory -Force | Select-Object -ExpandProperty Name)
$UnrelatedBefore = @($BeforeTopLevel | Where-Object { $_ -notin $SelectedSkills -and $_ -ne '.nexus-backup' })
$RemovedUnrelated = @($UnrelatedBefore | Where-Object { $_ -notin $AfterTopLevel })
if ($RemovedUnrelated.Count -gt 0) {
    $Failures.Add("unrelated skills disappeared: $($RemovedUnrelated -join ', ')")
}

$ClaudeCommand = Get-Command claude -ErrorAction SilentlyContinue
$ClaudeStatus = if ($null -eq $ClaudeCommand) {
    'Claude Code CLI was not found in PATH. Filesystem verification completed; fresh-session discovery still needs local confirmation.'
}
else {
    $version = (& claude --version 2>$null | Select-Object -First 1)
    if ([string]::IsNullOrWhiteSpace([string]$version)) { $version = 'version unavailable' }
    "Claude Code CLI detected ($version). This script does not invent an unsupported skill-index command; open a fresh Claude Code session for final discovery/use confirmation."
}

$Status = if ($Failures.Count -eq 0) { 'PASS' } else { 'FAIL' }
$ReportLines = @(
    '# NEXUS Claude Code Skill Verification',
    '',
    "- Status: **$Status**",
    "- Generated: $(Get-Date -Format o)",
    "- Scope: $Scope",
    "- Skills directory: ``$SkillsDir``",
    "- Canonical source: ``$CanonicalSkillsDir``",
    "- Verified skills: $($Verified.Count) / $($SelectedSkills.Count)",
    "- Claude Code: $ClaudeStatus",
    '',
    '## Selected skills',
    ''
)
$ReportLines += @($SelectedSkills | ForEach-Object { "- $_" })
$ReportLines += @('', '## Install/update result', '')
$ReportLines += "- Newly installed: $($Installed.Count)"
$ReportLines += "- Updated: $($Updated.Count)"
$ReportLines += "- Unrelated pre-existing skill folders preserved: $($RemovedUnrelated.Count -eq 0)"
if (-not $VerifyOnly -and (Test-Path -LiteralPath $BackupRoot)) {
    $ReportLines += "- Backup: ``$BackupRoot``"
}
$ReportLines += @('', '## Duplicate check', '')
if ($DuplicateDetails.Count -eq 0) {
    $ReportLines += '- No duplicate manifests found for the selected NEXUS skills.'
}
else {
    $ReportLines += @($DuplicateDetails | ForEach-Object { "- $_" })
}
$ReportLines += @('', '## Failures', '')
if ($Failures.Count -eq 0) {
    $ReportLines += '- None.'
}
else {
    $ReportLines += @($Failures | ForEach-Object { "- $_" })
}
$ReportLines += @(
    '',
    '## Final local gate',
    '',
    'Close all Claude Code sessions, start a fresh session, and confirm the six priority skills are discoverable and route correctly. That live Claude Code discovery step cannot be truthfully completed by a filesystem-only installer.'
)

$ReportLines | Set-Content -LiteralPath $ReportPath -Encoding UTF8

Write-Host "NEXUS skill verification: $Status"
Write-Host "Verified: $($Verified.Count)/$($SelectedSkills.Count)"
Write-Host "Report: $ReportPath"
if (-not $VerifyOnly -and (Test-Path -LiteralPath $BackupRoot)) {
    Write-Host "Backup: $BackupRoot"
}
Write-Host $ClaudeStatus

if ($Failures.Count -gt 0) {
    $Failures | ForEach-Object { Write-Error $_ }
    exit 1
}
