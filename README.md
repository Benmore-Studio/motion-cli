# blitz-cli

A tiny, **zero-dependency** command-line client for [Blitz](https://www.getblitz.app) — your AI Rolodex. Log context, search everything, run follow-up sequences, and send email or iMessage, right from your terminal.

It's a thin client over Blitz's **MCP** tools, and it authenticates with the same **OAuth (Google)** login your AI agent uses — no API keys to manage. On a Mac it can send iMessages **from your own number** by driving Messages locally.

## Install

Requires **Python 3.9+** (already on macOS and most Linux). No pip, no packages.

```sh
curl -fsSL https://raw.githubusercontent.com/Benmore-Studio/blitz-cli/main/install.sh | sh
```

Or grab the single file directly:

```sh
curl -fsSL https://raw.githubusercontent.com/Benmore-Studio/blitz-cli/main/blitz -o /usr/local/bin/blitz
chmod +x /usr/local/bin/blitz
```

## Quickstart

```sh
blitz login                 # opens your browser, sign in with Google
blitz agenda                # everything you owe, soonest first
blitz search "pricing"      # search contacts AND everything you've logged
blitz log "Jane Doe" "Great call, wants a pilot" --follow-up "send proposal" --due 2026-08-01
blitz brief 42              # full dossier on a contact
blitz imessage 42 "Hey! Following up on our chat"   # sends from your Mac
```

## Commands

| Command | What it does |
|---|---|
| `login` / `logout` / `whoami` | OAuth session management |
| `agenda` | open follow-ups, soonest first |
| `queue` | scheduled follow-up/sequence steps |
| `due` | steps due to send right now |
| `channels` | connected messaging channels |
| `search <query>` | search contacts + context |
| `contacts [query]` | list / search contacts |
| `brief <id>` | full dossier on a contact |
| `log <target> <content>` | log context (`--kind`, `--follow-up`, `--due`) |
| `send-email <to> <subject> <body>` | send via your connected inbox (`--draft`, `--target-id`) |
| `imessage <id> <message>` | send an iMessage from your Mac, logged to the Rolodex (`--draft`) |
| `queue-followup <id> <note>` | schedule a step (`--channel`, `--days`, `--sequence`) |
| `reply <id>` | record a reply → cancels that contact's queued steps |
| `tool <name> [json]` | call any Blitz MCP tool directly |

Run `blitz <command> --help` for details.

## How auth works

`blitz login` performs a standard **OAuth 2.1 Authorization Code + PKCE** flow against your Blitz instance's built-in authorization server (dynamic client registration, no secret). Your access token is stored at `~/.config/blitz/config.json` (mode `600`) and sent as a Bearer token. Nothing is shared with any third party.

## iMessage

`blitz imessage` asks Blitz to compose + log the message, then runs the returned AppleScript **locally** via `osascript`, so the text is sent from your own number through Messages.app. Requirements: macOS, Messages signed into iMessage, and the one-time Automation permission prompt approved. The contact must have a phone number in Blitz.

## Self-hosting / other instances

Point at any Blitz deployment:

```sh
BLITZ_URL="https://your-blitz.example.com" blitz login
```

The URL is saved with your login, so subsequent commands use it automatically.

## Upgrading from the `motion` CLI

Blitz was previously called Motion. The command is now `blitz`, config lives in `~/.config/blitz/`, and the env var is `BLITZ_URL`. Your **existing login carries over** — the old `~/.config/motion/config.json` is still read if the new one isn't there, and `MOTION_URL` is still honoured. Remove the old binary when you're ready: `sudo rm /usr/local/bin/motion`.

## License

MIT © Benmore. See [LICENSE](LICENSE).
