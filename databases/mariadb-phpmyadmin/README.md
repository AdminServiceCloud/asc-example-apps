# 🦭🔧 mariadb-phpmyadmin

A two-app stack ([asc.stack.yaml](asc.stack.yaml)): [MariaDB](db) paired
with [phpMyAdmin](phpmyadmin), a web-based administration UI.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install mariadb-phpmyadmin
asc app settings mariadb      # set the root password
asc app settings phpmyadmin   # optional: upload limit, fixed host
asc app start mariadb
asc app start phpmyadmin
```

Open phpMyAdmin on its published port (default `8080`): the login page asks
for **Server** — enter this machine's address (or `localhost` if browsing
from it) and the `mariadb` app's published port (default `3306`), plus the
root (or additional user) credentials.

## 📖 What it demonstrates

Same pattern as [mysql-phpmyadmin](../mysql-phpmyadmin) — see its README
for why phpMyAdmin's `PMA_ARBITRARY` mode sidesteps ASC not yet sharing a
Docker network between stack apps. This stack exists side by side with it
so MariaDB and MySQL can be compared directly.
