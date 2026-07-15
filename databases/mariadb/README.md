# 🦭 mariadb

MariaDB as a long-running database (`type: docker`), image **pinned to an
upstream LTS release** (`mariadb:11.4`).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install mariadb
asc app settings mariadb   # set the root password
asc app start mariadb
```

## 📖 What it demonstrates

- the official `mariadb` image's modern `MARIADB_*` environment variables
  (the older `MYSQL_*` names still work on the image, but the package uses
  the current ones) — same shape as the [mysql](../mysql) example, so the
  two are easy to compare side by side;
- `type: ports` (3306) and `type: volumes` (`/var/lib/mysql`).
