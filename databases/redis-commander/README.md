# 🟥🔧 redis-commander

A two-app stack ([asc.stack.yaml](asc.stack.yaml)): [Redis](db) paired with
[Redis Commander](commander), a web-based administration UI.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install redis-commander
asc app settings redis      # set a password
asc app settings commander  # point db_host/db_password at redis, set ui_password
asc app start redis
asc app start commander
```

Open Redis Commander on its published port (default `8081`) and log in with
`ui_username`/`ui_password`.

## 🗺️ Why a manual `db_host`

ASC does not yet put a stack's apps on a shared Docker network with
resolvable hostnames, so `commander` cannot reach `redis` by container
name — `db_host` is a required setting you point at wherever `redis`'s
published port is reachable (e.g. this machine's address), same reasoning
as [mongodb-mongoexpress](../mongodb-mongoexpress).

## 📖 What it demonstrates

- pairing an admin tool with the [redis](../redis) `start_command` example:
  the admin tool's `db_password` must match whatever `redis`'s own
  `password` setting was given;
- Redis Commander's **own separate login** (`ui_username`/`ui_password`)
  versus the database credentials it connects with underneath.
