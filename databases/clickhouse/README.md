# 🟧 clickhouse

ClickHouse as a long-running database (`type: docker`), image **pinned to an
upstream release** (`clickhouse/clickhouse-server:24.6.1`) so
`asc app upgrade clickhouse` moves to the next release predictably.
Originally created at Yandex and now developed by ClickHouse Inc.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install clickhouse
asc app settings clickhouse   # set the default user's password
asc app start clickhouse
```

Connect over HTTP (default `8123`, e.g. `clickhouse-client` `--host`/`--port
9000` or any HTTP client hitting `/`) or the native protocol (default `9000`).

## 📖 What it demonstrates

- environment variables the official image documents: `database`
  (`CLICKHOUSE_DB`), `username` (`CLICKHOUSE_USER`), `password`
  (`CLICKHOUSE_PASSWORD`, `secret`), and `access_management`
  (`CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT`, off by default);
- two independent `type: ports` settings for a single app — HTTP (`8123`)
  and the native protocol (`9000`) — each published on the host without an
  `env:`, since the image always listens on those ports internally;
- `type: volumes` for both the data directory and the log directory;
- `healthcheck.http: /ping`, ClickHouse's dedicated liveness endpoint on the
  HTTP port.
