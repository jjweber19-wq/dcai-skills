---
name: dcai-trips-and-courses
description: Check a dive shop's boat trips and courses in DCAI Desktop (seats left, manifests, waivers, rosters), find certified divers to fill empty seats, and book people when the key allows it. Use when the user asks what's going out, who's on a boat, how full a course is, or how to fill a trip. Needs the dcai-cli skill.
---

# Boat trips and courses

Read the `dcai-cli` skill first.

## Boat trips

```bash
dcai call trips_list                              # the trip going now and the next 6 days
dcai call trip_manifest '{"id":"<trip id>"}'      # divers, certs, waivers, check-in
```

- A diver can't be checked in on a boat without a valid waiver (waivers last a year). When a manifest shows a missing or old waiver, say who, so the shop can send a phone waiver link before the day.
- Seats left = the boat's capacity minus the divers booked. Report it per trip.

### Fill a trip

```bash
dcai call divers_for_trip '{"trip_id":"<trip id>"}'
```

Certified adults who aren't booked on that trip, most recent visit first (30 at most), with their certs. Pick the ones whose certs fit the dive (deep or wreck dives need the right card). Then either:
- draft one email per diver with `draft_email` and their `customer_id`, or
- draft one post about the trip with `draft_post`.

See the `dcai-marketing-drafts` skill. Don't book anyone who hasn't said yes.

### Money (keys that see revenue)

```bash
dcai call trip_revenue '{"from":"2026-11-01","to":"2026-11-30"}'
```

## Courses

```bash
dcai call courses_week '{"date":"2026-11-26"}'   # the courses in the week around that day
dcai call course_get '{"id":"<course id>"}'      # roster, pending payments, spots left
```

## Booking (Makes changes like Staff keys only)

```bash
dcai call trip_book '{"trip_id":"<trip id>","customer_id":"<customer id>"}'
dcai call course_add_student '{"course_id":"<course id>","customer_id":"<customer id>"}'
```

The fee goes on the customer's balance; payment happens at the shop. Confirm with the user first ("Book Sam Rivera on Saturday's 8 AM boat?"), and only book someone who asked to go.
