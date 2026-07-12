# 👋 helloworld

The smallest useful ASC package: a single [asc.yaml](asc.yaml) that runs a tiny
"Hello World" web server as a Docker container on port `8000`.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install helloworld
curl http://localhost:8000
```

## 📖 What it demonstrates

- the minimal set of `asc.yaml` fields: `name`, `version`, `type: docker`, `runtime.image`;
- `ports`, `requirements` and an HTTP `healthcheck`.
