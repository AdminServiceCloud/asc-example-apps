# 🎮 cs2 — Counter-Strike 2 stack with a shared master installation

A two-app stack ([asc.stack.yaml](asc.stack.yaml)) showing how game servers can
**share one copy of the game files** instead of each downloading ~60 GB:

| App | What it does |
|---|---|
| [master/](master) | 🗄️ SteamCMD keeps the CS2 game files (VPKs) in the named volume `cs2-master-data`, then exits |
| [server/](server) | 🕹️ The dedicated server: mounts `cs2-master-data` **read-only** and keeps its own configs/logs in a private volume |

```
┌─────────────┐   writes    ┌──────────────────┐   read-only   ┌─────────────┐
│ cs2-master  │ ──────────▶ │  cs2-master-data │ ◀──────────── │ cs2-server  │
│ (SteamCMD)  │             │  (named volume,  │ ◀──────────── │ cs2-server2 │
└─────────────┘             │   VPK files)     │ ◀──────────── │     ...     │
                            └──────────────────┘               └─────────────┘
```

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install cs2            # the whole stack (master first — depends_on)
asc install cs2/server     # one more server instance on the same master volume
asc app settings cs2-server  # set the GSLT token, RCON password, game mode
```

> 🔑 A [Game Server Login Token](https://steamcommunity.com/dev/managegameservers)
> (app 730) is required for the server to accept public connections.

## 📖 What it demonstrates

- `asc.stack.yaml`: several apps in one repository, `depends_on` startup order,
  shared stack `env` (`STEAM_APP_ID`);
- **volume linking**: both apps reference the same named volume
  `cs2-master-data` — the master writes game files, servers mount them `:ro`;
- `start_command` with `${VAR}` interpolation (the master's SteamCMD command);
- settings of every type: `string` with `limits`, `enum`, `number`, `secret`;
- per-app resource `quota` (100 G disk for the master, 4 G RAM per server).
