#import "../../page.typ": conf
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= What is accounting

I am taking a course about accounting this semester. Soon I became quite
interested in the topic, as it provides a systematic way to track and analyze
financial activities. In this post, I will share some basic concepts of
accounting and how I use #link("https://hledger.org")[hledger] to manage my
personal finances.

== It all starts with balancing equation

Accounting begins with one fundamental idea: every transaction affects at least
two accounts and must hold the balance sheet equation.

If that's not clear, let's dive into an example:

- I purchased a computer for CNY 2,400, paying CNY 2,000 in cash and borrowing
  CNY 400 from Alice. This is a single transaction. What did I give up? CNY
  2,000 in cash. What did I receive? A computer worth CNY 2,400 (a price most
  people would agree on in the market, assuming that it's a fair deal). The
  remaining CNY 400 isn't free: it's what I owe my friend, so it becomes a
  liability.

Then how would an accountant record this transaction? It would probably appear
in the ledger like this:

```
2025-01-01 buy new computer
    assets:cash  CNY -2000
    assets:computer CNY 2400
    liabilities:payable:alice CNY 400
```

Here you may still find it ambigious. What is an account though? The short
answer is that an account is basically a named container that keeps track of
changes in value related to a specific thing.

== Accounts and financial statements overview

We group accounts into five major categories. This convention is universal, used
by both multinational corporations and individuals tracking their daily
expenses.

- *Assets*: Resources you own that have economic value. In a personal context,
  this means your bank accounts (`assets:cash:boc:debit`, a debit card, for
  example) and perhaps items like computers that generate revenues. Recorded
  permanently.
- *Liabilities*: Obligations you owe to others. Credit card balances
  (`liabilities:credit-card`) are the most common example here. Recorded
  permanently.
- *Equity*: Your net worth. It bridges the gap between what you own and what you
  owe (`Assets - Liabilities = Equity`). Recorded permanently.
- *Revenues*: Value flowing in. Salary, gifts, or interest. Recorded
  periodically.
- *Expenses*: Value flowing out. Food, rent, transportation, and subscriptions.
  Recorded periodically.

By organizing transactions into these buckets, we can generate powerful reports.
Below is an example of a *Balance Sheet*, which captures the state of your
*Assets* and *Liabilities* at a specific moment.

```sh
hledger bs --tree --no-elide
```

```
Balance Sheet 2025-10-31

              ||              2025-10-31
==============++=========================
 Assets       ||
--------------++-------------------------
 assets       || CNY 17372.07, USD 42.51
   cash       || CNY 13558.39, USD 42.51
     boc      ||            CNY 13423.05
       debit  ||            CNY 13423.05
     icbc     ||   CNY 135.34, USD 42.51
       credit ||    CNY 21.70, USD 20.00
       debit  ||   CNY 113.64, USD 22.51
   payment    ||              CNY 113.68
     alipay   ||                CNY 0.17
     tsinghua ||               CNY 49.91
     wechat   ||               CNY 63.60
   receivable ||             CNY 3700.00
     deposit  ||             CNY 3700.00
--------------++-------------------------
              || CNY 17372.07, USD 42.51
==============++=========================
 Liabilities  ||
--------------++-------------------------
--------------++-------------------------
              ||                       0
==============++=========================
 Net:         || CNY 17372.07, USD 42.51
```

While the Balance Sheet shows you where you stand, the *Income Statement* tells
you how you got there. It summarizes your *Revenues* and *Expenses* over a
period of time, showing you whether you are saving money (net profit) or burning
through your savings (net loss).

```sh
hledger is --tree --no-elide -p 2025-10
```

```
Income Statement 2025-10

                ||         Oct
================++=============
 Revenues       ||
----------------++-------------
 revenues       || CNY 8100.11
   gift         || CNY 1000.00
   shopping     ||    CNY 0.11
     taobao     ||    CNY 0.11
   tsinghua     || CNY 3500.00
   work         || CNY 3600.00
----------------++-------------
                || CNY 8100.11
================++=============
 Expenses       ||
----------------++-------------
 expenses       || CNY 5348.16
   food         ||  CNY 944.37
     delivery   ||  CNY 208.38
     drink      ||  CNY 103.50
     fastfood   ||   CNY 73.64
     meal       ||  CNY 348.50
     restaurant ||  CNY 172.35
     snack      ||   CNY 38.00
   housing      || CNY 3850.00
     power      ||  CNY 150.00
     rent       || CNY 3700.00
   misc         ||   CNY 51.10
     book       ||   CNY 51.10
   shopping     ||  CNY 347.83
     taobao     ||  CNY 347.83
   subscribe    ||   CNY 80.00
     apple      ||   CNY 80.00
   transport    ||   CNY 74.86
     charge     ||   CNY 32.00
     subway     ||    CNY 5.00
     taxi       ||   CNY 37.86
----------------++-------------
                || CNY 5348.16
================++=============
 Net:           || CNY 2751.95
```
