# DCAI skills

Agent Skills for [DCAI Desktop](https://divecenter.ai/), dive shop software that runs on the shop's own computer. They teach your AI to find customers and their Next best sale, check boat trips and courses, see the day at the shop, and write emails and posts into DCAI's **AI drafts** inbox, where a person at the shop reviews and sends them.

These skills follow the [Agent Skills specification](https://agentskills.io/specification), so they work with any agent that supports skills.

## Before you start

1. Open **DCAI Desktop** on the shop's main computer, signed in as the Owner.
2. Go to **Settings → Agents** and press **Turn on the dcai command**. Pick what your AI may see (the first choice, no contact details, is the safe default).
3. Install the skills in your AI (below), then open a new terminal or restart the AI app.
4. Ask: *"Check that DCAI is reachable."*

Your AI must run on the same computer as DCAI. AIs that only run in the cloud can't reach the shop's computer, by design: DCAI never puts the shop's data on the internet.

## Install

### Claude

Claude Code:

```sh
claude plugin marketplace add jjweber19-wq/dcai-skills
claude plugin install dcai@dcai-skills
```

From within a Claude Code session:

```sh
/plugin marketplace add jjweber19-wq/dcai-skills
/plugin install dcai@dcai-skills
```

The Claude desktop app: use **Connect Claude** in DCAI → Settings → Agents instead. It adds DCAI to Claude with one click.

### ChatGPT and Codex

```sh
codex plugin marketplace add jjweber19-wq/dcai-skills
```

Then install DCAI from the plugin directory in Codex or the ChatGPT desktop app.

### Cursor

Add this repository as a plugin marketplace in Cursor, then install **DCAI**.

### Grok Bot

Ask your Bot to install the skills from https://github.com/jjweber19-wq/dcai-skills. Its worker must run on the shop's computer.

### Antigravity

```sh
agy plugin install https://github.com/jjweber19-wq/dcai-skills
```

### Hermes, Kiro, GitHub Copilot, OpenCode and other agents

Install with [npx skills](https://github.com/vercel-labs/skills), which asks which agents to install into:

```sh
npx skills add https://github.com/jjweber19-wq/dcai-skills
```

To install by hand, copy the folders in `plugins/dcai/skills/` into your agent's skills folder.

### Apps that take an MCP server instead

DCAI → Settings → Agents → **Your AI takes an MCP server instead** shows the exact entry (`dcai mcp`).

## Skills

| Skill | What it does |
| --- | --- |
| [dcai-cli](plugins/dcai/skills/dcai-cli) | Reach DCAI with the `dcai` command: connect, list tools, call one, read refusals |
| [dcai-customers](plugins/dcai/skills/dcai-customers) | Find customers, read their profile (certs, Gear Card, waiver, air cards, gift certificates, what they owe) and Next best sale, find who's due for a refresher |
| [dcai-trips-and-courses](plugins/dcai/skills/dcai-trips-and-courses) | Boat trips, boats, manifests and waivers, dive travel (who's going, one email to all of them), courses, filling empty seats |
| [dcai-marketing-drafts](plugins/dcai/skills/dcai-marketing-drafts) | Write emails and posts into DCAI's AI drafts inbox for the shop to send; see the lists, campaigns and automatic emails |
| [dcai-shop-day](plugins/dcai/skills/dcai-shop-day) | Sales, gear, rentals, repairs, air cards, website bookings, phone waivers and sign-ups, staff, and a morning summary |

These skills need DCAI Desktop with the AG.06 tools (Nov 26, 2026 or later). An older DCAI answers with fewer tools; `dcai tools` shows what's there.

## Privacy

Your AI talks to DCAI on the shop's own computer only. What it reads goes to your AI company under your own account and its terms. DCAI's key is kept in the computer's keychain; the skills never ask for it. Nothing reaches a customer until a person presses Send in DCAI.

## Release maintenance

Set the version in every manifest with `./scripts/bump.sh 0.2.0`, and run `./scripts/check.sh` before a release.
