# 🌐 nginx

Nginx as a long-running web server: `type: docker` with the image **pinned to an
upstream release** (`nginx:1.28`). The package version tracks the nginx release,
so upgrading the package upgrades the server predictably.

For nginx as a one-off command-line tool see [../nginx-utility](../nginx-utility).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install nginx
asc app settings nginx   # change ports / workers, then restart
```

## 📖 What it demonstrates

- a pinned Docker image version (`runtime.image: nginx:1.28`);
- a separate [asc.settings.yaml](asc.settings.yaml): `number` settings with `limits`,
  an `enum` setting, values exposed to the app via `env:`;
- a resource `quota` (CPU / RAM / disk);
- persistent `volumes` for config, content and logs.
