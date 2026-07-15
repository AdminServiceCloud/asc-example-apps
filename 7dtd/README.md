# 🧟 7dtd — 7 Days to Die dedicated server

A single-app example ([asc.yaml](asc.yaml)) running the
[renegademaster/7_days_to_die-dedicated-server](https://github.com/Renegade-Master/7_days_to_die-dedicated-server)
image. The image downloads the game itself via SteamCMD on first start; the
installation and the server config live in this instance's **private
volumes** (`server_files`, `server_config`), so they survive container
recreation and upgrades.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install 7dtd
asc app start 7dtd   # first start downloads the game
```

## 📖 What it demonstrates

- every setting maps 1:1 to an environment variable of the image, as
  documented on its [Docker Hub page](https://hub.docker.com/r/renegademaster/7_days_to_die-dedicated-server):
  `SERVER_NAME`, `SERVER_DESC`, `GAME_VERSION`, `PUBLIC_SERVER`,
  `MAX_PLAYERS`, `SERVER_PASSWORD`, `SERVER_LOG_FILE`, `QUERY_PORT`;
- **`allow_custom` on an `enum` setting** (`game_version`): the image accepts
  the presets `public`/`latest_experimental`, but also any other SteamCMD
  branch or build id — the setting lists the presets and still accepts a
  custom value typed in instead;
- `type: ports` with `protocol: both` (`game_port`, published on the host
  **and** exposed via env so the server listens where Docker forwards) next
  to a second `ports` setting with no `env:` (`extra_game_ports`) for the two
  companion UDP ports the image always derives from the query port
  (`game_port+1`, `game_port+2`);
- two `type: volumes` settings: a plain path (game files, in the app's
  `data` folder) and a `:host_folder` path (server config, in its own
  folder next to `data`);
- resource `quota` (25 G disk, 4 G RAM, 2 CPUs).

## 🔌 Ports

`game_port` (default `26900`, TCP+UDP) and `extra_game_ports` (default
`26901`, `26902`, UDP) must stay `game_port`/`game_port+1`/`game_port+2` —
the image has no environment variable for the two extra ports, it always
derives them from `QUERY_PORT`.
