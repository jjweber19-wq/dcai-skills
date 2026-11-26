---
name: dcai-shop-day
description: Answer everyday questions about a dive shop from DCAI Desktop - today's sales, a sales report, gear and stock, rentals out, the repairs board, air cards, new website bookings, waivers and sign-ups from phones, and who's working - and suggest one thing to send today. Use when the user asks how the shop is doing, what's out, what's in for repair, what's low on stock, what came in online, or for a daily summary. Needs the dcai-cli skill.
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

## Air cards

```bash
dcai call air_cards_list
```

The packs the shop sells (fills, air or nitrox, price) and how much is still owed in unused fills (keys that see money). A customer's own cards are in `customer_get`. If air cards are switched off in DCAI, the call says so.

## Online: website bookings and phone forms

```bash
dcai call online_bookings     # bookings from the shop's website booking box, newest first
dcai call phone_signups       # waivers and sign-up forms filled in on people's phones
```

- `needs_call: true` or `seen: false` means someone at the shop should look at it. Say who and what.
- `outcome_label` says whether DCAI matched the person to a customer or needs staff to pick one.
- You can't approve or match them: that's done in DCAI.

## Staff

```bash
dcai call staff_list
```

Names, roles (Owner, Admin, Staff), last sign-in, and who's on the clock now.

## A morning summary

When asked "how's the shop" or for a daily rundown, combine:
1. `trips_list`: what goes out today and tomorrow, seats left, missing waivers.
2. `courses_week` for today: courses running.
3. `rentals_list`: anything overdue.
4. `repairs_list`: tickets ready for pickup.
5. `online_bookings` and `phone_signups`: anything new or waiting on staff.
6. `travel_list`: a dive travel trip leaving within two weeks, or a final payment due soon.
7. `sales_today` (if the key sees money).

End with one suggestion to send something today, for example a post for the emptiest trip or an email to people `due_for_refresher`, and offer to draft it (the `dcai-marketing-drafts` skill).
