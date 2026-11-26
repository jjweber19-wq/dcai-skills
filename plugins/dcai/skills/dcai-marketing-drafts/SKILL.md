---
name: dcai-marketing-drafts
description: Write emails and social media posts for a dive shop and save them into DCAI Desktop's AI drafts inbox, where a person at the shop reviews, edits and sends them. Covers marketing lists (including one dive travel trip's travelers), campaigns and automatic emails, one-customer emails with {first_name}, post drafts, the shop's voice, and posting to the user's own connected social accounts. Use when the user asks to write, draft or send an email, newsletter, promo, reminder or post for their shop. Needs the dcai-cli skill.
---

# Emails and posts into DCAI

Read the `dcai-cli` skill first.

**You write; a person sends.** `draft_email` and `draft_post` save a draft in DCAI → Marketing → AI drafts. Nothing reaches a customer until someone at the shop presses Send. Every key kind may draft. Tell the user where the draft is: "It's in DCAI under Marketing → AI drafts."

## Email to a list

```bash
dcai call marketing_lists
```

Each list has a `key`, a `name` and how many opted-in adults it reaches (keys that see the shop's numbers only). Then:

```bash
dcai call draft_email '{"list_key":"<key>","subject":"Nitrox weekend, two seats left","body":"Hi {first_name},\n\n...","about":"Nitrox weekend promo"}'
```

List keys you'll see: ready-made ones (`nitrox`, …), the shop's own lists (`custom:<id>`), campaigns (`campaign:<id>`), and one per upcoming dive travel trip (`travel:<travel trip id>`, "Travelers: Mexico (Dec 3–7)").

When the shop sends to a list, DCAI only sends to opted-in adults, adds the unsubscribe line and paces the sending. Don't add your own unsubscribe text.

## What the shop already sends

```bash
dcai call marketing_board
```

Lists, campaigns, the automatic emails (birthday, lapsed, reminders) and whether each is on, the most recent emails sent, and how many people opted in or unsubscribed. Check it before suggesting an email the shop's automations already send.

## Email to one customer

```bash
dcai call draft_email '{"customer_id":"<id>","subject":"Your regulator is due for service","body":"Hi {first_name},\n\n...","about":"Service reminder"}'
```

- Use `list_key` or `customer_id`, never both.
- Write `{first_name}` where the name goes. DCAI fills it in when it sends. Never type a customer's real name, email or phone into a draft.
- Good sources: `next_best_sale` from `customer_get`, `due_for_refresher`, `divers_for_trip` (see the other DCAI skills).

## Post

```bash
dcai call draft_post '{"text":"Saturday we head out to the wreck...","about":"Saturday boat trip"}'
```

No customer names, phone numbers or emails in a post. The shop adds a photo and posts from DCAI (Facebook, Instagram, or Copy the words).

Then tell the user: "The post is in DCAI under Marketing → AI drafts. Add a photo and press **Post to Facebook and Instagram** (or just one of them): DCAI copies the words and opens the page for you to paste and publish." That's the shop's usual way of posting from DCAI.

### Posting yourself

If the user has connected their own social accounts to you (for example Instagram or Facebook) and asks you to post, you may post with those tools: that's the user's own AI acting for them. Save the post as a DCAI draft too, so the shop has a record, and confirm the exact words with the user before you publish.

## Example: one ask, a count, an email and a post

The user: *"How many people are signed up for the trip to Mexico next week? Draft me an email to them and park it in DCAI. Also draft a post for social, and send it the usual way."*

1. `dcai call travel_list`. Find the Mexico trip that starts next week. Answer: "6 of 8 spots booked for Cozumel, Dec 3–7."
2. `dcai call travel_get '{"id":"<id>"}'` for the facts: dates, final payment day, what's included.
3. `dcai call draft_email '{"list_key":"travel:<id>","subject":"Cozumel next week: what to bring","body":"Hi {first_name},\n\n...","about":"Mexico trip, one week out"}'`
4. `dcai call draft_post '{"text":"One week until Cozumel! ...","about":"Mexico trip post"}'`. No traveler names in a post.
5. Tell the user: "Both are in DCAI → Marketing → AI drafts. Open the email and press Send; open the post and press Post to Facebook and Instagram." If the user connected their social accounts to you and asked you to post, confirm the exact words and post it yourself, and keep the DCAI draft as the record.

## The shop's voice

- Short, warm and specific: the date, the site, seats left, the price. One clear ask ("Reply to book", "Call the shop", "Stop by Saturday").
- Plain words a diver uses. No hype, no ALL CAPS, at most one emoji in a post and none in emails.
- Subject lines under 60 characters.
- Use only facts from DCAI or the user: real trip dates, real prices (`price_cents` ÷ 100), real seats left. If you don't know, leave it out or ask.
- Sign emails from the shop, not from an AI.
- For safety claims (depths, certifications, medical), keep to what the agency card allows; don't promise what a course doesn't include.

## Check before you finish

1. The list or customer is right (and you used `customer_id`, not a name).
2. `{first_name}` is spelled exactly like that.
3. Every date, price and seat count came from DCAI.
4. You told the user the draft is waiting in Marketing → AI drafts.
