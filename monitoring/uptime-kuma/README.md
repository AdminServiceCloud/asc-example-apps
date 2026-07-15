# 🟢 uptime-kuma

[Uptime Kuma](https://github.com/louislam/uptime-kuma), a self-hosted
uptime monitor with a built-in status page, notifications and a slick UI.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install uptime-kuma
asc app start uptime-kuma
```

Open the published port (default `3001`) and complete the first-run setup
wizard to create the admin account.

## 📖 What it demonstrates

- an app with almost **no env-based settings** by design — only the
  published port is a real setting, everything else (admin account,
  monitors, notification channels, status pages) is configured through the
  app's own UI and stored in its `data` volume;
- a minimal `type: ports` + `type: volumes` package, similar in spirit to
  [helloworld](../../web/helloworld) but a real, useful long-running
  service.
