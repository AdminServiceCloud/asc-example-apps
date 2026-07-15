# 📊 grafana

Grafana OSS as a long-running dashboard server (`type: docker`), image
**pinned to an upstream release** (`grafana/grafana-oss:11.2.0`).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install grafana
asc app settings grafana   # set the admin password
asc app start grafana
```

Log in on the published port (default `3000`) with `admin_user`/
`admin_password`, then add a data source (Prometheus, one of the
[databases](../../databases) examples, etc.) from the UI.

## 📖 What it demonstrates

- Grafana's `GF_<SECTION>_<KEY>` convention: every setting maps to a
  `grafana.ini` value (`GF_SECURITY_ADMIN_PASSWORD`,
  `GF_USERS_ALLOW_SIGN_UP`, `GF_SERVER_ROOT_URL`, `GF_SERVER_HTTP_PORT`) —
  the same pattern extends to any other grafana.ini setting the package
  author wants to expose;
- `type: ports` and `type: volumes` for the dashboards/plugins database.
