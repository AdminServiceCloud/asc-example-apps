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

## 🎮 GPU acceleration

Out of the box the package runs on the CPU — a manifest cannot decide which
of a host's graphics cards an app may use, so the choice is the owner's. To
use the GPU, attach it after the install:

```bash
asc hardware                 # lists the cards with their PCI addresses
asc app settings ollama      # category "gpus": toggle the cards to attach
asc app restart ollama       # the container is recreated with the cards
```

On the platform the same choice is Settings → Resources → Graphics cards.
NVIDIA cards need the proprietary driver and the NVIDIA Container Toolkit on
the host; AMD and Intel cards need a DRM render node. (`asc hardware` says
which cards can be attached and why not.) Requires asc-daemon 0.55.0 or newer.
Without a GPU, expect noticeably slower inference; size `requirements`/`quota`
and model choice accordingly.

## 📖 What it demonstrates

- an app whose real resource needs (RAM, disk for model weights) go far
  past every other example in this registry — `requirements`/`quota` sized
  for actually running a small-to-medium model, not just the base image;
- a `models` volume that can legitimately grow to tens of GB per model
  pulled, unlike the modest data volumes elsewhere.
