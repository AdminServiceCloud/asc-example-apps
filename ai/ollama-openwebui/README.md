# 🦙💬 ollama-openwebui

A two-app stack ([asc.stack.yaml](asc.stack.yaml)): [Ollama](ollama) paired
with [Open WebUI](openwebui), a ChatGPT-style chat interface.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install ollama-openwebui
asc app settings openwebui   # point ollama_base_url at ollama, set secret_key
asc app start ollama
asc app start openwebui
```

Open Open WebUI on its published port (default `8080`), create the first
account (it becomes the admin), then pull a model from **Settings → Models**
— it goes through to the `ollama` app underneath.

## 🗺️ Why a manual `ollama_base_url`

Same reasoning as the [database + admin-tool stacks](../../databases): ASC
does not yet put a stack's apps on a shared Docker network with resolvable
hostnames, so `openwebui` cannot reach `ollama` by container name —
`ollama_base_url` is a required setting you point at wherever `ollama`'s
published API port is reachable.

## 📖 What it demonstrates

- pairing a heavyweight backend ([ollama](../../ollama), RAM/disk sized for
  actually running a model) with a lightweight, stateless-except-for-chat-
  history frontend in the same stack;
- the same cross-app "point it at the sibling's published port" pattern as
  [mongodb-mongoexpress](../../databases/mongodb-mongoexpress) and
  [redis-commander](../../databases/redis-commander), applied outside the
  databases category.
