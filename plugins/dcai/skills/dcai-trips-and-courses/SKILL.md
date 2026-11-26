---
name: dcai-trips-and-courses
description: Check a dive shop's boat trips, dive travel (trips away) and courses in DCAI Desktop (seats left, manifests, waivers, rosters, who's going on a travel trip), find certified divers to fill empty seats, and book people when the key allows it. Use when the user asks what's going out, who's on a boat or a travel trip, how many signed up, how full a course is, or how to fill a trip. Needs the dcai-cli skill.
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

### Boats

```bash
dcai call boats_list      # the shop's boats, capacity, and crew
```

### Money (keys that see revenue)

```bash
dcai call trip_revenue '{"from":"2026-11-01","to":"2026-11-30"}'
```

## Dive travel (trips away)

Dive travel is the shop's group trips away from home (a week in Cozumel, a liveaboard in the Bahamas), separate from the daily boat trips.

```bash
dcai call travel_list                       # trips not over yet, soonest first
dcai call travel_get '{"id":"<travel trip id>"}'
dcai call travel_revenue '{"from":"2026-01-01","to":"2026-12-31"}'   # keys that see revenue
```

- `travel_list` gives each trip's `destination`, `place`, `dates_label`, `days_until`, `spots`, `booked`, `spots_left`, and `rooms` with the travelers in each.
- `travel_get` adds the price, deposit, final payment day (`final_due_label`) and what each traveler still owes.
- "The trip to Mexico next week": match `destination` or `place`, and check the dates. If two trips fit, ask which.
- To email everyone going, use the list key `travel:<travel trip id>` with `draft_email` (the `dcai-marketing-drafts` skill). It reaches the travelers who opted in to email; mention to the user if `booked` is more than the list's count, so the shop can tell the rest in person.

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
