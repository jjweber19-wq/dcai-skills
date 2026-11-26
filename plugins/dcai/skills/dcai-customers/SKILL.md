---
name: dcai-customers
description: Look up a dive shop's customers in DCAI Desktop, read their profile (certifications, Gear Card, waiver, air cards, gift certificates, what they owe, loyalty points, history), explain their Next best sale, find divers due for a refresher, and add notes or customers when the key allows it. Use when the user asks about a customer, who to call or email, what to sell someone, or who hasn't been in for a while. Needs the dcai-cli skill.
---

# Customers and Next best sale

Read the `dcai-cli` skill first. Run `dcai status` before the first call.

## Find someone

```bash
dcai call customers_search '{"query":"Jordan"}'
dcai call customers_search '{"query":"Jordan","include_inactive":true}'
```

The query matches a name, customer number or phone digits. Several matches: show the user a short list (name, customer number, last visit) and ask which one. Never pick for them when it matters.

## Their profile

```bash
dcai call customer_get '{"id":"<id from customers_search>"}'
```

The answer has `customer` (details), `certs`, `gear` (the Gear Card: what they own, by slot), `last_purchase`, `next_best_sale`, `balance_due_cents` and `pay_status`, `loyalty_points` (when the shop uses loyalty), `guardians` and `juniors`, `past` (sales, courses and trips brought in from the shop's old system), and:
- `waiver`: `state` and `pill` (signed, expiring, expired or none), `signed_at`, `expires_on`. Waivers last a year.
- `air_cards`: their air and nitrox fill cards and fills left.
- `gift_certificates`: `held` (certificates they can spend, with what's left) and `bought` (ones they bought for someone else).
- `open_invoices`: each sale they still owe on, with the amount due.

The profile note (`customer.note`) is the shop's "note for next visit".

Summarize in shop words: "Advanced Open Water since 2022, owns a BCD and computer, no regulator, owes $120, last in March."

## Next best sale

`next_best_sale` is DCAI's own pick, made from simple rules with no AI: the first piece missing from the customer's Gear Card, with products from the shop's price list for it (stale stock first, then cheapest).

- `headline` and `reason` say why in plain words. Use them; don't invent a different reason.
- `suggestions` are real products with `price_cents` and `on_hand`. Suggest only these, at these prices.
- `null` means DCAI has nothing to suggest (their Gear Card is full, or nothing on the price list fits). Say so.

To turn a Next best sale into an email, use `draft_email` with this `customer_id` (the `dcai-marketing-drafts` skill). The shop sends it.

## Who to win back

```bash
dcai call due_for_refresher '{"months":12}'
```

Certified adults with no visit in that many months (1 to 60, default 12) but one in the last five years, most recent first, 50 at most. Good for refresher, welcome-back or "dust off your gear" emails. No contact details come back: draft to each by `customer_id`, or to a marketing list.

## Phone and email

Only with a key that has contact details:

```bash
dcai call customer_contact '{"id":"<id>"}'
```

Refused otherwise. You rarely need it: drafts take a `customer_id`, and DCAI fills in the address when a person sends.

## Changes (Makes changes like Staff keys only)

```bash
dcai call customer_note '{"id":"<id>","note":"Wants a drysuit course in spring"}'
dcai call customer_add '{"customer":{"first_name":"Sam","last_name":"Rivera","birth_date":"1990-04-12","note":"Walk-in, asked about Open Water"}}'
dcai call customer_update '{"id":"<id>","customer":{"note":"..."}}'
```

- `customer_note` replaces the profile note: read it with `customer_get` first and keep what's there.
- Before `customer_add`, search for the person first so you don't make a duplicate.
- Confirm with the user before any change, in one line: what you'll change and for whom.
- Juniors (under 18) are never listed for keys without contact details, and staff keys can't change phone or email.
