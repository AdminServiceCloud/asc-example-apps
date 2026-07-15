# 🍃 mongodb

MongoDB as a long-running database (`type: docker`), image **pinned to an
upstream release** (`mongo:8.0`).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install mongodb
asc app settings mongodb   # set root_username/root_password to enable auth
asc app start mongodb
```

Without `root_username`/`root_password` the instance starts with
**authentication disabled** — fine for a private network, not for anything
internet-facing.

## 📖 What it demonstrates

- the official `mongo` image's environment variables: optional
  `root_username`/`root_password` (`MONGO_INITDB_ROOT_*`) that turn on
  authentication only when both are set, and an optional `database`
  (`MONGO_INITDB_DATABASE`, only meaningful together with init scripts);
- `type: ports` (27017) and `type: volumes` (`/data/db`).
