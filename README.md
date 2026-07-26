# motion-cli

A tiny, **zero-dependency** command-line client for [Motion](https://motion-v9t7fg.benmore.ai) — the agent-driven personal CRM. Log context, search everything, run follow-up sequences, and send email or iMessage, right from your terminal.

It's a thin client over Motion's **MCP** tools, and it authenticates with the same **OAuth (Google)** login your AI agent uses — no API keys to manage. On a Mac it can send iMessages **from your own number** by driving Messages locally.

## Install

Requires **Python 3.9+** (already on macOS and most Linux). No pip, no packages.

```sh
curl -fsSL https://raw.githubusercontent.com/benmore-tech/motion-cli/main/install.sh | sh
```

Or grab the single file directly:

```sh
curl -fsSL https://raw.githubusercontent.com/benmore-tech/motion-cli/main/motion -o /usr/local/bin/motion
chmod +x /usr/local/bin/motion
```

## Quickstart

```sh
motion login                 # opens your browser, sign in with Google
motion agenda                # everything you owe, soonest first
motion search "pricing"      # search contacts AND everything you've logged
motion log "Jane Doe" "Great call, wants a pilot" --follow-up "send proposal" --due 2026-08-01
motion brief 42              # full dossier on a contact
motion imessage 42 "Hey! Following up on our chat"   # sends from your Mac
```

## Commands

| Command | What it does |
|---|---|
| `login` / `logout` / `whoami` | OAuth session management |
| `agenda` | open follow-ups, soonest first |
| `queue` | scheduled follow-up/sequence steps |
| `due` | steps due to send right now |
| `search <query>` | search contacts + context |
| `contacts [query]` | list / search contacts |
| `brief <id>` | full dossier on a contact |
| `log <target> <content>` | log context (`--kind`, `--follow-up`, `--due`) |
| `send-email <to> <subject> <body>` | send via your connected inbox (`--target-id`) |
| `imessage <id> <message>` | send an iMessage from your Mac, logged to the CRM |
| `queue-followup <id> <note>` | schedule a step (`--channel`, `--days`, `--sequence`) |
| `reply <id>` | record a reply → cancels that contact's queued steps |
| `tool <name> [json]` | call any Motion MCP tool directly |

Run `motion <command> --help` for details.

## How auth works

`motion login` performs a standard **OAuth 2.1 Authorization Code + PKCE** flow against your Motion instance's built-in authorization server (dynamic client registration, no secret). Your access token is stored at `~/.config/motion/config.json` (mode `600`) and sent as a Bearer token. Nothing is shared with any third party.

## iMessage

`motion imessage` asks Motion to compose + log the message, then runs the returned AppleScript **locally** via `osascript`, so the text is sent from your own number through Messages.app. Requirements: macOS, Messages signed into iMessage, and the one-time Automation permission prompt approved. The contact must have a phone number in Motion.

## Self-hosting / other instances

Point at any Motion deployment:

```sh
MOTION_URL="https://your-motion.example.com" motion login
```

The URL is saved with your login, so subsequent commands use it automatically.

## License

MIT © Benmore. See [LICENSE](LICENSE).
