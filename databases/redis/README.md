# 🟥 redis

Redis as a long-running cache/store (`type: docker`), image **pinned to an
upstream release** (`redis:7.2`).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install redis
asc app settings redis   # set a password
asc app start redis
```

## 📖 What it demonstrates

- **`start_command` (DMN-018)** as the way to configure an image that has no
  env-based configuration at all: every setting (`password`, `append_only`,
  `maxmemory`, `maxmemory_policy`, `port`) is threaded into
  `redis-server --requirepass ${REDIS_PASSWORD} ...` via `${VAR}`
  interpolation, replacing the image's default command;
- why this is safe for Redis specifically but not for the database
  examples next to it: the official `redis` image's entrypoint is a thin
  argument-detection convenience, not first-run setup, so replacing it
  outright loses nothing — `postgres`/`mysql`/`mariadb`/`mongodb` run real
  initialization in their entrypoints and must be left alone;
- `type: ports` (6379) and `type: volumes` (`/data`), both also referenced
  from `start_command`.
