# 🎮 cs2 — Counter-Strike 2 dedicated server

A one-app stack ([asc.stack.yaml](asc.stack.yaml)) running the
[joedwards32/cs2](https://github.com/joedwards32/CS2) dedicated server image.
The image downloads and updates the game (~60 GB) itself via SteamCMD on
start; the whole installation plus the instance's configs/logs/demos live in
a **private volume** under `/asc/apps/cs2-server/data/`, so they survive
container recreation and upgrades.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install cs2
asc app settings cs2-server  # set the GSLT token, RCON password, game mode
asc app start cs2-server     # first start downloads the game (~60 GB)
```

> 🔑 A [Game Server Login Token](https://steamcommunity.com/dev/managegameservers)
> (app 730) is required for the server to accept public connections.

## 📖 What it demonstrates

- `asc.stack.yaml`: the stack layout (apps in subdirectories of one repository);
- `runtime: stdin/tty` — the container is created like `docker run -it`, so
  `asc attach cs2-server` is a real interactive server console;
- settings of every type: `string` with `limits`, `enum` (game mode, start
  map — `CS2_STARTMAP` goes into the server launch as `+map`), `number`,
  `secret`, `ports` (published on the host **and** exposed via env, so the
  server always listens where Docker forwards) and `volumes` (the game
  installation in the app's `data` folder, `/asc/apps/<id>/data`);
- resource `quota` (100 G disk, 4 G RAM, 2 CPUs).

## 🗺️ Planned: a shared master installation

The original design — one "master" app keeping the game files in a shared
named volume mounted read-only by every server instance (no per-instance
~60 GB download) — is on hold until the daemon implements:

- `start_command` execution from `asc.settings.yaml` (DMN-018), which the
  master's SteamCMD run needs;
- a copy-up overlay for the image's writable paths: the joedwards32/cs2
  entrypoint writes configs and scripts into its game directory, so a plain
  read-only mount cannot feed it.
