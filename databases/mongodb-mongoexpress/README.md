# 🍃🔧 mongodb-mongoexpress

A two-app stack ([asc.stack.yaml](asc.stack.yaml)): [MongoDB](db) paired
with [mongo-express](mongoexpress), a web-based administration UI.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install mongodb-mongoexpress
asc app settings mongodb      # set root_username/root_password
asc app settings mongoexpress # point db_host at where mongodb's port is published,
                               # matching db_admin_username/password, set ui_password
asc app start mongodb
asc app start mongoexpress
```

Open mongo-express on its published port (default `8081`) and log in with
`ui_username`/`ui_password`.

## 🗺️ Why a manual `db_host`

ASC does not yet put a stack's apps on a shared Docker network with
resolvable hostnames, so `mongoexpress` cannot reach `mongodb` by container
name. Unlike phpMyAdmin ([mysql-phpmyadmin](../mysql-phpmyadmin)),
mongo-express has no "ask at login" mode — its target database is fixed at
container creation via `ME_CONFIG_MONGODB_SERVER` — so `db_host` is a
required setting you point at wherever `mongodb`'s published port is
reachable (e.g. this machine's address).

## 📖 What it demonstrates

- a stack where the admin tool's settings **mirror the database's own
  credentials** (`db_admin_username`/`db_admin_password` vs `mongodb`'s
  `root_username`/`root_password`) — a real, working cross-app
  configuration, done manually because ASC has no way yet to pass one
  app's setting value into another's default;
- the admin tool's **own separate login** (`ui_username`/`ui_password`,
  HTTP basic auth in front of the UI) versus the database credentials it
  connects with underneath.
