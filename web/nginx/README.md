# 🌐 nginx

Nginx as a long-running web server: `type: docker` with the image **pinned to an
upstream release** (`nginx:1.28`). The package version tracks the nginx release,
so upgrading the package upgrades the server predictably.

For nginx as a one-off command-line tool see [../../system-utilities/nginx-utility](../../system-utilities/nginx-utility).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install nginx
asc app settings nginx   # change ports / workers, then restart
```

## 📖 What it demonstrates

- a pinned Docker image version (`runtime.image: nginx:1.28`);
- a separate [asc.settings.yaml](asc.settings.yaml): `type: ports` settings
  with `limits` (published on the host and exposed via `env:`), an `enum`
  setting (`worker_processes`), a plain `string` (`timezone`);
- a resource `quota` (CPU / RAM / disk);
- `type: volumes` for config, content and logs, each in its own folder
  (`:conf`, `:html`, `:logs`) rather than sharing the app's default `data`
  folder.
