# 🐘 postgresql

PostgreSQL as a long-running database (`type: docker`), image **pinned to an
upstream release** (`postgres:16.3`) so `asc app upgrade postgresql` moves to
the next release predictably.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install postgresql
asc app settings postgresql   # set the superuser password
asc app start postgresql
```

Connect from another app or the host at the published port (default `5432`).

## 📖 What it demonstrates

- every setting the official `postgres` image documents: `username`
  (`POSTGRES_USER`), `password` (`POSTGRES_PASSWORD`, `secret`), `database`
  (`POSTGRES_DB`, left unset by default so the image falls back to the
  superuser name), and `PGDATA` pointed at a subdirectory of the mount so
  `initdb` doesn't choke on a non-empty mount point;
- `type: ports` published on the host without an `env:` — the container
  always listens on 5432 internally, only the host-side port is
  configurable;
- `type: volumes` for the data directory, in the app's `data` folder.
