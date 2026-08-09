#!/usr/bin/env bash
#
# Render an artifact-style HTML report to a print-ready PDF.
#
# Artifact HTML is written for a live viewer: no <html>/<head>/<body> wrapper, and
# a theme-aware palette that reacts to prefers-color-scheme. A PDF is a fixed light
# medium, so this script:
#   - wraps the fragment into a real document
#   - strips the dark-theme token blocks (deterministic light output)
#   - adds print CSS: A4, tables that fit instead of scrolling, no page breaks
#     inside cards/rows/code blocks, repeated table headers
#   - renders with headless Chromium
#   - verifies the result has real extractable text (not an image scan)
#
# Usage: ./report-to-pdf.sh input.html [output.pdf]
#
set -euo pipefail

IN="${1:?usage: report-to-pdf.sh input.html [output.pdf]}"
OUT="${2:-${IN%.html}.pdf}"
WORK="$(mktemp -d)"
PRINT="$WORK/print.html"
CHROME="${CHROME:-/opt/pw-browsers/chromium}"
[ -x "$CHROME" ] || CHROME="$(command -v chromium || command -v google-chrome || command -v chromium-browser)"

python3 - "$IN" "$PRINT" <<'PY'
import re, sys
src = open(sys.argv[1], encoding="utf-8").read()

def strip_block(text, pat):
    m = re.search(pat, text)
    while m:
        i = text.index("{", m.start()); depth = 0
        for j in range(i, len(text)):
            if text[j] == "{": depth += 1
            elif text[j] == "}":
                depth -= 1
                if depth == 0:
                    text = text[:m.start()] + text[j+1:]; break
        else:
            break
        m = re.search(pat, text)
    return text

src = strip_block(src, r'@media \(prefers-color-scheme:\s*dark\)\s*')
src = strip_block(src, r':root\[data-theme="dark"\]\s*')

PRINT_CSS = """
<style>
  @page { size: A4; margin: 13mm 12mm 12mm; }
  html, body { background:#FFFFFF !important; }
  body { font-size:12.4px; line-height:1.55; }
  .wrap { max-width:none; padding:0; gap:22px; }
  .scroll { overflow:visible !important; border-radius:6px; }
  table { min-width:0 !important; width:100%; font-size:10.4px; table-layout:fixed; }
  th, td { padding:5px 7px; word-wrap:break-word; overflow-wrap:anywhere; }
  th { font-size:9px; letter-spacing:.06em; }
  td.slug, td.n { font-size:9.6px; white-space:normal; }
  code { font-size:.85em; padding:.05em .25em; }
  pre { font-size:9.8px; line-height:1.6; padding:9px 10px;
        white-space:pre-wrap; overflow-wrap:anywhere; }
  .card, .stat, tr, .step, pre, .verdict { break-inside:avoid; page-break-inside:avoid; }
  h1, h2, h3, .sec-head { break-after:avoid; page-break-after:avoid; }
  thead { display:table-header-group; }
  h1 { font-size:31px; } h2 { font-size:19px; } h3 { font-size:13px; }
  .lede { font-size:13.4px; } .eyebrow { font-size:9.4px; }
  .stat b { font-size:20px; } .stat span { font-size:10px; } .stat { padding:10px 12px; }
  .card { padding:12px 14px; } .card p { font-size:12px; }
  .verdict { padding:15px 17px; } .verdict p { font-size:12.6px; }
  p, ul, ol { max-width:none; }
  .note { font-size:11.2px; } footer { font-size:10.8px; }
  a { text-decoration:none; }
</style>
"""

m = re.search(r"(<div class=\"wrap\">.*</div>\s*)$", src, re.S)
if not m:
    sys.exit("could not find the <div class=\"wrap\"> ... </div> body")
head, body = src[:m.start()], m.group(1)
open(sys.argv[2], "w", encoding="utf-8").write(
    '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n'
    '<meta name="viewport" content="width=device-width,initial-scale=1">\n'
    + head + PRINT_CSS + "\n</head>\n<body>\n" + body + "\n</body>\n</html>"
)
PY

rm -f "$OUT"
"$CHROME" --headless --no-sandbox --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$OUT" "file://$PRINT" 2>&1 | grep -i "bytes written" || true

python3 - "$OUT" <<'PY'
import sys
try:
    import pypdfium2 as pdfium
except ImportError:
    sys.exit("pypdfium2 not installed — cannot verify (pip install pypdfium2)")
pdf = pdfium.PdfDocument(sys.argv[1])
txt = "\n".join(p.get_textpage().get_text_range() for p in pdf)
w, h = pdf[0].get_size()
words = len(txt.split())
print(f"verified: {len(pdf)} pages, {w:.0f}x{h:.0f}pt, {words} extractable words")
if words < 100:
    sys.exit("FAIL: almost no extractable text — the PDF may be blank or image-only")
PY

echo "wrote $OUT"
rm -rf "$WORK"
