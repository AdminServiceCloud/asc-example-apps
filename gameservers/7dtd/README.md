# 🧟 7dtd — 7 Days to Die dedicated server

A single-app example ([asc.yaml](asc.yaml)) building its **own image**
([Dockerfile](Dockerfile) + [entrypoint.sh](entrypoint.sh)) instead of
pulling a prebuilt one. No maintained third-party image exposes every game
setting (name, password, max players, visibility, difficulty...) as an
environment variable — LinuxGSM-based images configure those through
`serverconfig.xml` edited by hand after install, and the previously used
`renegademaster/7_days_to_die-dedicated-server` image did neither reliably
(its entrypoint ignored a failed SteamCMD update and then crashed trying to
copy a config template that was never installed).

The entrypoint runs SteamCMD anonymously and passes every setting straight
to the `7DaysToDieServer.x86_64` binary as a `-PropertyName=value` override
on top of its own bundled `serverconfig.xml` — the same mechanism the
[official Pterodactyl egg](https://github.com/pterodactyl/game-eggs/blob/main/7_days_to_die/egg-7-days-to-die.json)
uses. The game installation and the saves/logs live in this instance's
**private volumes** (`server_files`, `server_data`), so they survive
container recreation and upgrades.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install 7dtd
asc app start 7dtd   # first start builds the image and downloads the game
```

## 📖 What it demonstrates

- `runtime.image-build` (build a Dockerfile bundled with the package)
  instead of `runtime.image` (pull a prebuilt one);
- a SteamCMD `app_update` retry loop in the entrypoint: on a cold cache, a
  single `+login anonymous +app_update <appid> +quit` reliably fails once
  with `ERROR! Failed to install app '294420' (Missing configuration)` —
  a known SteamCMD quirk, not specific to this app — and succeeds on an
  immediate retry once the local appinfo cache is warm;
- **`allow_custom` on an `enum` setting** (`game_version`): the entrypoint
  accepts the presets `public`/`latest_experimental`, but also any other
  SteamCMD branch id typed in instead;
- `type: ports` with `protocol: both` (`game_port`, published on the host
  **and** exposed via env so the server listens where Docker forwards) next
  to a second `ports` setting with no `env:` (`extra_game_ports`) for the two
  companion UDP ports the server always opens relative to the game port
  (`game_port+1`, `game_port+2`);
- two `type: volumes` settings: game files (large, disposable, redownload
  survives recreation) kept separate from saves/logs;
- resource `quota` (25 G disk, 4 G RAM, 2 CPUs).

## 🔌 Ports

`game_port` (default `26900`, TCP+UDP) and `extra_game_ports` (default
`26901`, `26902`, UDP) must stay `game_port`/`game_port+1`/`game_port+2` —
the server always opens those two relative to `-ServerPort`. `telnet_port`
(default `8081`) is intentionally **not** published on the host; it's only
reachable inside the app's own Docker network, so leaving `telnet_password`
empty is fine as long as it stays that way.

## ⚠️ Not build/run-tested end-to-end

The Dockerfile builds cleanly and the SteamCMD retry fix was verified live
(reproduced the "Missing configuration" failure on a cold cache, confirmed
an immediate retry succeeds and the ~17.5 GB download proceeds normally).
The full install → game binary launch → healthcheck path was **not** run to
completion (large download, skipped once the fix was confirmed) — verify
that before relying on this in production.
