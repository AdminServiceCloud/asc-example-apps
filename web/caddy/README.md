# 🕸️ caddy

Caddy as a long-running web server/reverse proxy (`type: docker`), image
**pinned to an upstream release** (`caddy:2.8.4`). Caddy's headline feature —
automatic HTTPS via ACME/Let's Encrypt — needs the `certs` volume to
persist across restarts.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install caddy
asc app start caddy
```

Edit the Caddyfile in the `caddyfile` volume (`/etc/caddy/Caddyfile` inside
the container) and restart to apply it — Caddy also supports zero-downtime
reloads, not yet exposed as an ASC command.

## 📖 What it demonstrates

- **`{$VAR}` substitution inside a config file**, Caddy's own equivalent of
  ASC's `env:` — `domain`/`acme_email` are ordinary settings whose only
  purpose is to land in the container's environment for your *own*
  Caddyfile to reference as `{$DOMAIN}`/`{$ACME_EMAIL}`; the package
  doesn't ship a Caddyfile that uses them;
- `protocol: both` on `https_port` — Caddy's automatic HTTP/3 needs the
  same port on UDP (QUIC) as well as TCP;
- three separate `type: volumes` for three different concerns: the
  Caddyfile itself, ACME/TLS state, and Caddy's autosaved running config.
