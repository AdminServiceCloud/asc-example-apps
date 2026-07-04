# 🧪 asc-example-apps — примеры приложений для AdminService.Cloud

Примеры приложений и манифестов `asc.yaml` для [asc-daemon](../asc-daemon): шаблоны для разработчиков, которые хотят упаковать своё приложение для магазина [AdminService.Cloud](../asc-platform) или кастомного реестра.

## 📂 Что внутри

| Пример | Описание |
|---|---|
| `helloworld/` | 👋 Минимальное Docker-приложение с `asc.yaml` и Dockerfile |
| `nginx.yaml` | 🌐 Веб-сервер (Docker) |
| `apache.yaml` | 🪶 Apache HTTP Server |
| `postgresql.yaml` | 🐘 PostgreSQL с автопровижинингом базы |
| `mysql.yaml` | 🐬 MySQL |
| `mongodb.yaml` | 🍃 MongoDB |
| `redis.yaml` | 🔴 Redis |

## 🚀 Как попробовать

```bash
# установка примера из локального каталога
asc source add file:///path/to/asc-example-apps
asc install helloworld
asc app logs helloworld
```

## ✍️ Как упаковать своё приложение

1. 📝 Создайте `asc.yaml` в корне репозитория (формат — [📦 package-manager](../asc-daemon/docs/package-manager.md)).
2. 🧪 Проверьте локально: `asc source add file://... && asc install <name>`.
3. 🛍️ Опубликуйте: PR в [официальный реестр](../registry) или подключите свой GitHub-репозиторий прямо в платформе.

## 📚 Документация и Roadmap

- [📦 Формат asc.yaml и реестров](../asc-daemon/docs/package-manager.md)
- [🛍️ Магазин приложений](../asc-platform/docs/features/app-store.md)
- [🎯 ROADMAP](../asc-platform/ROADMAP.md) — задача примеров: `REG-002`

> ⚠️ Каталог `old/` — прошлые наработки, используется как справка.
