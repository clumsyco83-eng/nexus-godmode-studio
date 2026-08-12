# Financial Formulas, Definitions and Traps

Reference material for Finance & Unit Economics Intelligence. Every definition here is one of
several in common use — what matters is that the definition in use is written down and held
constant. Most financial disagreements are definitional, not factual.

## Contents

1. Revenue and margin
2. Acquisition and payback
3. Lifetime value and churn
4. Break-even and runway
5. Return on ad spend
6. Cash flow modeling
7. Sensitivity analysis
8. Worked example
9. Common traps

---

## 1. Revenue and margin

```text
Net revenue per unit  = list price − discounts − refunds − chargebacks − platform fees
                        − payment processing fees

Gross margin          = net revenue − cost of goods sold
Gross margin %        = gross margin / net revenue

Contribution margin   = net revenue − ALL costs that vary with the sale
Contribution margin % = contribution margin / net revenue
```

**Contribution margin is the number that governs scaling decisions.** Gross margin usually omits
costs that are unmistakably variable: support time per customer, delivery, returns processing, and
per-transaction fees. A product with 70% gross margin and 5% contribution margin does not survive
growth.

Variable costs to include, in the order they are usually forgotten: payment processing (typically
2–4% plus a fixed fee), refunds and chargebacks, returns including shipping both ways, support
time per customer at a real hourly rate, delivery and packaging, marketplace commission, and any
per-seat or per-transaction software cost.

---

## 2. Acquisition and payback

```text
CAC = (total acquisition spend + hours × rate) / customers acquired, same period

Payback period = CAC / contribution margin per period
```

Two rules that change the answer materially:

- **Include hours.** A channel with zero media spend consuming ten hours a week is not free. At any
  reasonable rate it is often the most expensive channel in the business.
- **Match the period.** Spend in January that produces customers in March gives a wrong figure both
  months. For channels with a lag, align the cohort to when the spend occurred.

**Blended CAC** (all spend / all customers, including organic) understates the cost of paid
acquisition and is the figure most often quoted. **Paid CAC** (paid spend / customers attributable
to paid) is the one that governs spend decisions. Report which is which.

---

## 3. Lifetime value and churn

```text
For subscriptions:
  Average lifetime (periods) = 1 / churn rate per period
  LTV = contribution margin per period × average lifetime

For repeat purchase:
  LTV = average contribution margin per order × orders per customer over the horizon

LTV/CAC = LTV / CAC
```

**Choose a horizon and say what it is.** "Lifetime" for a business fourteen months old is not
observable; a 12-month or 24-month value is. Infinite-horizon LTV derived from an early churn rate
is the most over-claimed number in small business finance.

**Churn definitions differ.** Customer churn (accounts lost / accounts at start) and revenue churn
(revenue lost / revenue at start) diverge sharply when customers differ in size. Net revenue churn
includes expansion and can be negative, which is good and should be labelled clearly rather than
looking like an error.

Churn early in a business is measured on small cohorts and is unstable. Treat an LTV built from
two months of data as an assumption, not a measurement.

**Interpreting LTV/CAC:** below 1 loses money on every customer; 1–2 is thin and absorbs no error;
3+ is generally healthy; far above 5 sometimes signals underinvestment in growth rather than
excellence. These are orientation points, not thresholds — payback period against available cash
matters more when cash is constrained.

---

## 4. Break-even and runway

```text
Break-even units    = fixed costs per period / contribution margin per unit
Break-even revenue  = fixed costs / contribution margin %

Runway (months)     = cash available / net cash burn per month
```

Break-even is undefined when contribution margin is zero or negative — no volume reaches
profitability. State that directly rather than producing a large number.

Runway uses **cash burn**, not accounting loss. They differ whenever there are receivables,
payables, prepayments, or inventory.

---

## 5. Return on ad spend

```text
ROAS = revenue attributable to ads / ad spend
```

ROAS uses revenue, so it says nothing about profitability. A 3× ROAS on a 20% contribution margin
loses money.

```text
Break-even ROAS = 1 / contribution margin %
```

At 30% contribution margin, break-even ROAS is 3.33× — anything below that is a loss regardless of
how healthy 3× sounds. Compute the break-even ROAS first and compare against it; a ROAS quoted
without margin context cannot be evaluated.

---

## 6. Cash flow modeling

Model cash separately from profit, always. The inputs are timing, not just amounts:

- when customers actually pay (immediately, on terms, in installments),
- when suppliers and contractors are paid,
- when platform payouts settle (often 2–14 days, sometimes with a rolling reserve),
- when tax and other periodic obligations fall due,
- inventory purchased before it is sold,
- refunds occurring after revenue is recognized.

Report the **lowest cash point** and when it occurs, not just the ending balance. A model that ends
the year positive while going to −$8,000 in month four describes a business that fails in month
four.

**Growth consumes cash** whenever costs precede receipts. The faster a business grows under those
conditions, the more cash it needs — which is why profitable businesses fail.

---

## 7. Sensitivity analysis

Vary one input at a time, holding others constant, and record the effect on the outcome.

```text
<input> −20%  →  <outcome>
<input> base  →  <outcome>
<input> +20%  →  <outcome>
```

The two or three inputs producing the widest swing are the **driving variables**. They are the ones
to verify with real evidence, and the ones that cap the model's confidence. Everything else can
stay assumed without much cost.

This is more useful than scenario planning for deciding what to investigate, because it identifies
where uncertainty actually matters rather than describing three futures.

---

## 8. Worked example

A physical product sold direct.

```text
INPUTS
  list price                  $49.00   [MEASURED]
  discount rate (average)      8%      [MEASURED, 6 months]
  payment fees                 2.9% + $0.30  [MEASURED]
  cost of goods                $14.00  [MEASURED]
  packaging + shipping         $6.20   [MEASURED]
  return rate                  12%     [MEASURED]
  return cost (shipping both ways + unsellable)  $9.10 per return  [ASSUMED — range $7–12]
  support                      0.15 h/order at $30/h = $4.50  [ASSUMED]
  paid CAC                     $18.00  [MEASURED, last 90 days]
  repeat orders per customer   1.4 over 12 months  [ASSUMED — 5 months of data]

UNIT ECONOMICS  (per order)
  net revenue    49.00 − 3.92 discount − 1.61 fees            = $43.47
  variable costs 14.00 + 6.20 + (0.12 × 9.10) + 4.50          = $25.79
  contribution margin                                          = $17.68  (40.7%)

  break-even ROAS = 1 / 0.407 = 2.46×

CUSTOMER LEVEL  (12-month horizon)
  contribution per customer  17.68 × 1.4                       = $24.75
  CAC                                                          = $18.00
  LTV/CAC                                                      = 1.38
  payback                    first order covers 17.68 of 18.00 → just over one order

SENSITIVITY
  return rate  8% → 16%    contribution $18.05 → $17.31   (modest)
  repeat rate  1.0 → 2.0   LTV/CAC 0.98 → 1.96            ← driving variable
  CAC          $14 → $24   LTV/CAC 1.77 → 1.03            ← driving variable

FINDING
  Viable but thin. The outcome is dominated by repeat rate, which rests on five months of
  data, and by CAC, which will likely rise with scale. At a repeat rate of 1.0 the business
  loses money on every customer.
  CONFIDENCE: low — capped by the assumed repeat rate, which drives the result.
  MUST VERIFY: 12-month repeat behavior; CAC stability at 3× current spend.
```

Note what this produces: not "the business works" or "does not work", but the specific figure to
go and measure before committing more money.

---

## 9. Common traps

- **Using gross margin for scaling decisions** when contribution margin is the relevant number.
- **Omitting payment fees**, which are 3–5% of revenue and always variable.
- **Ignoring refunds and returns** — often the largest single variable cost in physical products.
- **Excluding the owner's time**, which makes an unviable business look viable until the owner
  stops working for free.
- **Blended CAC quoted as paid CAC**, understating paid acquisition cost, sometimes severely.
- **Infinite-horizon LTV** from a few months of churn data.
- **Mismatched periods** between spend and the customers it produced.
- **ROAS without break-even ROAS**, making a losing campaign look successful.
- **Ending balance instead of lowest cash point**, hiding the month the business runs out.
- **Point estimates** implying precision the inputs do not support.
- **Reverse-engineering assumptions** until the model produces the desired answer — the most
  damaging error available, because it produces a confident document supporting a bad decision.
- **Comparing metrics across a definition change** without noting it.
