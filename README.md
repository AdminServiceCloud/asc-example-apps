# 🧪 asc-example-apps — example applications for AdminService.Cloud

> 🌍 **Language:** English · [🇷🇺 Русская версия](docs/russian/README.md)

Example applications and `asc.yaml` manifests for [asc-daemon](../asc-daemon): templates for developers who want to package their application for the [AdminService.Cloud](../asc-platform) app store or a custom registry.

## 📂 What's inside

| Example | Description |
|---|---|
| `helloworld/` | 👋 Minimal Docker application with `asc.yaml` and a Dockerfile |
| `nginx.yaml` | 🌐 Web server (Docker) |
| `apache.yaml` | 🪶 Apache HTTP Server |
| `postgresql.yaml` | 🐘 PostgreSQL with automatic database provisioning |
| `mysql.yaml` | 🐬 MySQL |
| `mongodb.yaml` | 🍃 MongoDB |
| `redis.yaml` | 🔴 Redis |

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
