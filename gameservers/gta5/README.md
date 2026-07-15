# 🚔 gta5 — GTA 5 server (FiveM)

A single-app example ([asc.yaml](asc.yaml)) running the
[spritsail/fivem](https://github.com/spritsail/fivem) image: FXServer (the
GTA V multiplayer server, "FiveM") plus its bundled
[txAdmin](https://github.com/citizenfx/txAdmin) web console for managing the
server, resources and admins without shelling in.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install gta5
asc app settings gta5   # set the Cfx.re license key from https://keymaster.fivem.net
asc app start gta5
```

Then open `http://<host>:40120` to finish txAdmin's first-run setup wizard
(or pre-fill it with `default_cfx_key`/`default_admin_account`).

## 📖 What it demonstrates

- environment variables from **two layers of one image**: the
  `spritsail/fivem` wrapper (`license_key`, `rcon_password`, `no_onesync`)
  and txAdmin's own documented `TXHOST_*` variables (`game_name`,
  `max_slots`, `quiet_mode`, `provider_name`, the `default_*` setup-wizard
  pre-fills, `api_token`);
- two `type: ports` settings on the same app: the FXServer game port
  (`protocol: both`, TCP+UDP) and the txAdmin web console port (TCP only);
- two `type: volumes` settings kept separate: server resources/mods/config
  in the app's `data` folder, txAdmin's own logs/config/database in their
  own `txdata` folder.
