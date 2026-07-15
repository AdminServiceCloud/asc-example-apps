# 🖥️ lm-studio

Headless [LM Studio](https://lmstudio.ai) — the `llmster` daemon, LM
Studio's server core without its desktop GUI — using the
[official Docker image](https://hub.docker.com/r/lmstudio/llmster-preview).
Pull, load and serve local models over an OpenAI-compatible API.

## ⚠️ Technical Preview

The upstream image is CPU-only on x86 and explicitly labeled a preview by
LM Studio; there are no numbered release tags to pin to yet (only
`:cpu`/`:latest`, currently identical), unlike every other pinned example
in this registry. Expect it to change. GPU acceleration isn't available in
this image today.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install lm-studio
asc app start lm-studio
```

Pull and load a model through the bundled `lms` CLI (`asc attach lm-studio`
for a shell, or from your own machine with `lms ... --host <host> --port
1234` once `lms` is installed locally):

```bash
lms get google/gemma-3-1b
lms load google/gemma-3-1b
curl http://localhost:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model": "google/gemma-3-1b", "messages": [{"role": "user", "content": "Hello!"}]}'
```

## 📖 What it demonstrates

- pinning a **channel tag** (`:cpu`) instead of a numbered version when the
  upstream simply doesn't publish one — contrast with
  [ollama](../ollama), which pins an actual release (`0.5.7`);
- an **OpenAI-compatible API** server, so anything already speaking that
  protocol (including [Open WebUI](../ollama-openwebui) via its own
  `OPENAI_API_BASE_URL`, not wired up in this package) can point at it
  interchangeably with Ollama;
- another single-volume, near-zero-settings package: `data` holds models,
  config and conversation history together, same shape as
  [uptime-kuma](../../monitoring/uptime-kuma).
