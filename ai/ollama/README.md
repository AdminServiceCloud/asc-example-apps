# 🦙 ollama

[Ollama](https://ollama.com) as a long-running LLM API server (`type:
docker`): pull open models and serve them over an HTTP API on the published
port, no UI included — see [ollama-openwebui](../ollama-openwebui) for a
chat interface on top of it.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install ollama
asc app start ollama
```

Pull and run a model through the API (or `asc attach` a shell in the
container and use the `ollama` CLI directly):

```bash
curl http://localhost:11434/api/pull -d '{"model": "llama3.2"}'
curl http://localhost:11434/api/generate -d '{"model": "llama3.2", "prompt": "Hello!"}'
```

## ⚠️ CPU-only under ASC today

The image supports NVIDIA/AMD GPU acceleration, but that requires passing
through host GPU devices to the container — `asc.schema.json`'s `runtime`
section has no such option yet, so this package runs CPU-only. Expect
noticeably slower inference than a GPU-enabled host running the same image
directly; size `requirements`/`quota` and model choice accordingly.

## 📖 What it demonstrates

- an app whose real resource needs (RAM, disk for model weights) go far
  past every other example in this registry — `requirements`/`quota` sized
  for actually running a small-to-medium model, not just the base image;
- a `models` volume that can legitimately grow to tens of GB per model
  pulled, unlike the modest data volumes elsewhere.
