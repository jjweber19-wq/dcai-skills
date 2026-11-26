---
name: dcai-shop-day
description: Answer everyday questions about a dive shop from DCAI Desktop - today's sales, a sales report, gear and stock, rentals out, and the repairs board - and suggest one thing to send today. Use when the user asks how the shop is doing, what's out, what's in for repair, what's low on stock, or for a daily summary. Needs the dcai-cli skill.
---

# The day at the shop

Read the `dcai-cli` skill first. Run the calls below, then answer in a few plain lines; don't paste raw JSON.

## Sales

```bash
dcai call sales_today
dcai call report_sales '{"from":"2026-11-01","to":"2026-11-30"}'   # keys that see revenue
```

Amounts are in cents. Staff-kind keys don't see money totals: say so if the user asks.

## Gear and stock

```bash
dcai call gear_list
dcai call gear_list '{"search":"regulator"}'
```

Products with price and on hand. Mention what's out of stock or low only when the user asks about stock or a sale.

## Rentals

```bash
dcai call rentals_list
dcai call rentals_list '{"category":"Tank"}'
```

What's out now, to whom, and when it's due back.

## Repairs and service

```bash
dcai call repairs_list
dcai call repairs_list '{"show_done":true}'
dcai call repair_get '{"id":"<ticket id>"}'
dcai call repair_note '{"id":"<ticket id>","text":"Parts ordered"}'   # Makes changes like Staff keys only
```

## A morning summary

When asked "how's the shop" or for a daily rundown, combine:
1. `trips_list`: what goes out today and tomorrow, seats left, missing waivers.
2. `courses_week` for today: courses running.
3. `rentals_list`: anything overdue.
4. `repairs_list`: tickets ready for pickup.
5. `sales_today` (if the key sees money).

End with one suggestion to send something today, for example a post for the emptiest trip or an email to people `due_for_refresher`, and offer to draft it (the `dcai-marketing-drafts` skill).
