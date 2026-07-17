# 🟨 ydb

YDB single-node local cluster (`type: docker`), image **pinned to an
upstream release** (`ydbplatform/local-ydb:24.3.11.13`) so
`asc app upgrade ydb` moves to the next release predictably. YDB is an open
source distributed SQL database developed at Yandex.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install ydb
asc app start ydb
```

Open the embedded Web UI at the published monitoring port (default `8765`),
or connect with the YDB CLI/SDK at the gRPC port (default `2136`,
endpoint `grpc://<host>:2136`, database path `/local`).

## 📖 What it demonstrates

- four independent `type: ports` settings for a single app — gRPC
  (`2136`/`GRPC_PORT`), gRPC TLS (`2135`/`GRPC_TLS_PORT`), the monitoring
  Web UI (`8765`/`MON_PORT`) and the Kafka-compatible proxy
  (`9092`/`YDB_KAFKA_PROXY_PORT`) — each with its own `env:` matching the
  image's variable for that port;
- a `boolean` setting (`in_memory_pdisks`, `YDB_USE_IN_MEMORY_PDISKS`) that
  trades persistence for speed, off by default so data survives restarts;
- `type: volumes` for both the data directory and the TLS certificates
  directory the image generates on first start;
- a `command` healthcheck (`curl` against the monitoring port) since the
  container publishes several ports and no single one is the "default" HTTP
  port.
