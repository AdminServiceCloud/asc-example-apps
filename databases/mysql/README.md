# 🐬 mysql

MySQL as a long-running database (`type: docker`), image **pinned to an
upstream LTS release** (`mysql:8.4`).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install mysql
asc app settings mysql   # set the root password
asc app start mysql
```

## 📖 What it demonstrates

- the official `mysql` image's environment variables: `root_password`
  (`MYSQL_ROOT_PASSWORD`, `secret`), an optional default `database`
  (`MYSQL_DATABASE`) and an optional additional `username`/`password`
  (`MYSQL_USER`/`MYSQL_PASSWORD`) — all left unset by default so
  `env_pairs` omits them entirely rather than passing empty strings;
- `type: ports` (3306) and `type: volumes` (`/var/lib/mysql`, in the app's
  `data` folder).
