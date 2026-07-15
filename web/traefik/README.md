# 🚦 traefik

Traefik as a long-running reverse proxy/load balancer (`type: docker`),
image **pinned to an upstream release** (`traefik:v3.1.4`).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install traefik
asc app start traefik
```

Open the dashboard on the HTTP port (default `80`, path `/dashboard/`) once
`dashboard`/`dashboard_insecure` are both on.

## 🗺️ Why no Docker-label routing

Traefik's usual party trick is discovering routes automatically from
**Docker labels** on the containers it proxies to (`traefik.http.routers...`
labels in a typical `docker-compose.yaml`). ASC apps don't expose custom
container labels yet, so this package instead mounts a `config` volume for
static **and** dynamic configuration files — add your routers/services
there and Traefik picks up changes live (its file provider watches for
changes by default).

## 📖 What it demonstrates

- **`TRAEFIK_<FLAG>`** environment variables — Traefik's own convention for
  setting static configuration via env instead of a file, the same idea as
  Grafana's `GF_*` variables in the [grafana](../../monitoring/grafana)
  example but for a different app;
- `protocol: both` on `https_port` for HTTP/3 (QUIC), same reasoning as
  [caddy](../caddy);
- a `certs` volume that must survive restarts, same reasoning as caddy's.
