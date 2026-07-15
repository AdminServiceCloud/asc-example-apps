# 🧪 asc-example-apps — example applications for AdminService.Cloud

> 🌍 **Language:** English · [🇷🇺 Русская версия](docs/russian/README.md)

Example applications and `asc.yaml` manifests for [asc-daemon](../asc-daemon): templates for developers who want to package their application for the [AdminService.Cloud](../asc-platform) app store or a custom registry.

## 📂 What's inside

Examples are grouped in folders that match their [registry](../registry) category, so `<category>/<package>` on disk lines up with the `path` a registry entry points at.

### 🌐 web/

| Example | Description |
|---|---|
| `web/helloworld/` | 👋 Minimal Docker application: `asc.yaml` + a one-setting `asc.settings.yaml` |
| `web/nginx/` | 🌐 Nginx web server pinned to an upstream release, with `asc.settings.yaml` (ports, volumes, quota) |
| `web/caddy/` | 🕸️ Caddy: automatic HTTPS, `{$VAR}` substitution inside a mounted Caddyfile |
| `web/traefik/` | 🚦 Traefik: reverse proxy configured via `TRAEFIK_*` env vars instead of Docker-label discovery |

### 🔧 system-utilities/

| Example | Description |
|---|---|
| `system-utilities/nginx-utility/` | 🧰 Nginx as an on-demand Docker utility (`type: utility`), no persistent service |
| `system-utilities/portainer/` | 🐳 Docker management UI; mounts the host's Docker socket as an absolute-path volume |

### 📈 monitoring/

| Example | Description |
|---|---|
| `monitoring/uptime-kuma/` | 🟢 Uptime monitoring with a public status page; almost no env-based settings |
| `monitoring/grafana/` | 📊 Dashboards, `GF_<SECTION>_<KEY>` env-var convention |
| `monitoring/server-speedtest/` | 🚀 Self-hosted network speed test; a 100-entry `type: ports` WebRTC range |

### 🧠 ai/

| Example | Description |
|---|---|
| `ai/ollama/` | 🦙 Local LLM runtime (CPU-only under ASC today — no GPU passthrough yet) |
| `ai/ollama-openwebui/` | 💬 Ollama paired with Open WebUI, a ChatGPT-style chat interface |
| `ai/lm-studio/` | 🖥️ Headless LM Studio (`llmster`), OpenAI-compatible API; a channel tag (`:cpu`) pinned instead of a version, since upstream has none yet |

### 🎮 gameservers/

| Example | Description |
|---|---|
| `gameservers/cs2/` | 🎮 Counter-Strike 2 stack (`asc.stack.yaml`): dedicated server with the game installation in a private per-instance volume |
| `gameservers/7dtd/` | 🧟 7 Days to Die dedicated server: every image env var mapped to a setting, including an `enum` with `allow_custom` |
| `gameservers/gta5/` | 🚔 GTA 5 server (FiveM): FXServer + its bundled txAdmin web console |

### 🗄️ databases/

| Example | Description |
|---|---|
| `databases/postgresql/`, `mysql/`, `mariadb/`, `mongodb/`, `redis/` | 🗄️ Each database standalone, pinned to an upstream release, official image env vars mapped 1:1 |
| `databases/postgresql-pgadmin/`, `mysql-phpmyadmin/`, `mariadb-phpmyadmin/`, `mongodb-mongoexpress/`, `redis-commander/` | 🔧 Each database paired with a web admin UI as a two-app `asc.stack.yaml` |

## 🚀 How to try

```bash
# install an example from a local directory
asc source add file:///path/to/asc-example-apps
asc install helloworld
asc app logs helloworld
```

## ✍️ How to package your own application

1. 📝 Create an `asc.yaml` at the root of your repository (format — [📦 package-manager](../asc-daemon/docs/package-manager.md)).
2. 🧪 Test locally: `asc source add file://... && asc install <name>`.
3. 🛍️ Publish: open a PR to the [official registry](../registry) or connect your own GitHub repository directly in the platform.

## 🧩 Multiple applications in one repository (asc.stack.yaml)

A single repository may contain **several applications** (several `asc.yaml` files in subdirectories) — but the root must hold **exactly one** manifest: either `asc.yaml`, or an `asc.stack.yaml` joining all the nested ones. A stack `asc.stack.yaml` lists the applications and the paths to their `asc.yaml`:

```yaml
name: my-stack
version: 1.0.0
apps:
  - name: web
    path: ./web        # directory containing asc.yaml
  - name: worker
    path: ./worker
```

- 📦 `asc install my-stack` — install the entire stack;
- 🎯 `asc install my-stack/web` — install a single application from the stack;
- 🔗 a stack can declare shared `env` and the application startup order.

More details in [📦 package-manager](../asc-daemon/docs/package-manager.md).

## 📚 Documentation and roadmap

- [📦 asc.yaml and registry format](../asc-daemon/docs/package-manager.md)
- [🛍️ App store](../asc-platform/docs/features/app-store.md)
- [🎯 ROADMAP](../asc-platform/ROADMAP.md) — examples task: `REG-002`

> ⚠️ The `old/` directory holds earlier work and is kept for reference only.

## 📄 License

MIT — see [LICENSE](LICENSE). `asc install` shows this license and asks for acceptance once per repository before installing any example from here.
