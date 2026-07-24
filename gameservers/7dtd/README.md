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
empty is fine as long as it stays that way. `web_dashboard_port` (default
`8080`) **is** published — it's a browser-facing admin panel, not a raw
unauthenticated console like telnet.

## 🖥️ Console and web dashboard

The game binary itself never reads admin commands from stdin on Linux
(confirmed against upstream/other Docker images of this game) — only
telnet. `asc attach` still gets you a live view of the game's own log
(tailed to stdout) and a TTY, but for commands connect to `telnet_port`
directly, e.g. from inside the container (`docker exec -i <container>
bash -c 'exec 3<>/dev/tcp/localhost/8081; echo "gettime" >&3; sleep 1;
timeout 1 cat <&3'`) or with a real telnet client if the port is published.

The web dashboard (`web_dashboard_enabled`, default on) has no account by
default, and — confirmed live, telnet rejects it outright with "Command
can only be executed from the in-game console" — `createwebuser` **cannot**
be bootstrapped from telnet, only from a real connected player's in-game
console. There's no way around actually launching the game client for this
one step:

1. Connect to the server as a player with the real game client.
2. From telnet (which needs no prior permission — it's the server owner's
   channel, not a player's), `listplayers` to find your entity id, then
   `admin add <entityid> 0` to grant that player permission level `0`.
3. In the connected game client's own console (default key **F1**), run
   `createwebuser <user> <password> 0`.
4. Open `http://<host>:<web_dashboard_port>/` and log in with that account.

`enable_map_rendering` (default on) is what powers the dashboard's live map
view.

## ✅ Verified live

Installed and run end to end on a real host, on game version **V 3.0.1
(b4)**, through several rounds of fixes: image build (BuildKit, DMN-050),
the SteamCMD cold-cache retry, a container-wide open-files limit bump
(`ulimit nofile`, an unrelated Steamworks EOS SDK hang), missing
`~/.steam/sdk32`/`sdk64` symlinks (`SteamGameServer_Init` failing silently
and leaving every connecting player stuck on "Server is still
initializing" even once the world had finished loading), console access
(telnet confirmed working; stdin does not, neither does `createwebuser`
specifically — see above), and the full web dashboard login flow (steps
1-4 above) — a player connected, granted themselves admin over telnet,
created a web user from the in-game console, and logged into the
dashboard successfully.
