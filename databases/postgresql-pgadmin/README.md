# 🐘🔧 postgresql-pgadmin

A two-app stack ([asc.stack.yaml](asc.stack.yaml)): [PostgreSQL](db) paired
with [pgAdmin](pgadmin), a web-based administration UI.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install postgresql-pgadmin
asc app settings postgresql   # set the superuser password
asc app settings pgadmin      # set the admin email/password
asc app start postgresql
asc app start pgadmin
```

Open pgAdmin on its published port (default `5050`) and add a new server
manually: **Host** = this machine's address (or `localhost` if browsing from
it), **Port** = the `postgresql` app's published port (default `5432`),
**Username**/**Password** = the ones set on `postgresql`.

## 🗺️ Why a manual connection

ASC does not yet put a stack's apps on a shared Docker network with
resolvable hostnames, so `pgadmin` cannot reach `postgresql` by container
name — only by whatever host address `postgresql`'s port is published on.
pgAdmin also has no simple env var for pre-registering a server (it needs a
mounted `servers.json`, outside what the settings model expresses today),
so the connection is one manual step in the UI rather than automatic.

## 📖 What it demonstrates

- a two-app stack where the second app is a **pure admin tool** with no
  data of its own beyond its UI preferences (`pgadmin`'s own `data` volume),
  as opposed to [cs2](../../gameservers/cs2)'s dependent-app pattern;
- `PGADMIN_LISTEN_PORT` — unlike plain `nginx`/`postgresql`, pgAdmin's
  internal port *is* configurable via env, so the `http_port` setting both
  publishes the host port and reconfigures the container to match.
