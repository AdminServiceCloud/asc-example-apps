# 🐬🔧 mysql-phpmyadmin

A two-app stack ([asc.stack.yaml](asc.stack.yaml)): [MySQL](db) paired with
[phpMyAdmin](phpmyadmin), a web-based administration UI.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install mysql-phpmyadmin
asc app settings mysql        # set the root password
asc app settings phpmyadmin   # optional: upload limit, fixed host
asc app start mysql
asc app start phpmyadmin
```

Open phpMyAdmin on its published port (default `8080`): the login page asks
for **Server** — enter this machine's address (or `localhost` if browsing
from it) and the `mysql` app's published port (default `3306`), plus the
root (or additional user) credentials.

## 🗺️ Why "arbitrary server" mode

ASC does not yet put a stack's apps on a shared Docker network with
resolvable hostnames, so `phpmyadmin` cannot reach `mysql` by container
name. Rather than requiring a fixed, manually-entered host (as the
[postgresql-pgadmin](../postgresql-pgadmin) stack does), phpMyAdmin has a
built-in escape hatch for exactly this — `PMA_ARBITRARY` — so the login
page itself asks where to connect. Turn `arbitrary_server` off and set
`fixed_host` instead if you'd rather pin it.

## 📖 What it demonstrates

- `PMA_ARBITRARY`: a setting (`arbitrary_server`) that sidesteps the
  cross-container networking gap entirely, instead of working around it
  like [mongodb-mongoexpress](../mongodb-mongoexpress) and
  [redis-commander](../redis-commander) do;
- the same MySQL settings as the [standalone mysql](../mysql) example,
  reused inside a stack.
