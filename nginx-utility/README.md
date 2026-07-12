# 🧰 nginx-utility

Nginx as a **utility**, not a service (`type: utility`): installing the package
just pulls the unpinned `nginx:alpine` image, and nginx is invoked as a one-off
Docker command whenever you need it. Nothing keeps running in the background.

For nginx as a persistent versioned web server see [../nginx](../nginx).

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install nginx-utility
```

## 🔧 Usage

```bash
# lint an nginx config without touching any running server
docker run --rm -v "$PWD/nginx.conf:/etc/nginx/nginx.conf:ro" nginx:alpine nginx -t

# serve the current directory on http://localhost:8080 until Ctrl+C
docker run --rm -p 8080:80 -v "$PWD:/usr/share/nginx/html:ro" nginx:alpine
```

## 📖 What it demonstrates

- `type: utility`: `runtime.install` / `runtime.uninstall` commands instead of a
  managed container — the daemon installs a tool, not a service;
- a deliberately unpinned image tag (utilities track the current upstream build).
