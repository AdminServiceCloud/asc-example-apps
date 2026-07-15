# 🧪 asc-example-apps — примеры приложений для AdminService.Cloud

> 🌍 **Язык:** Русский · [🇬🇧 English version](../../README.md)

Примеры приложений и манифестов `asc.yaml` для [asc-daemon](../../../asc-daemon): шаблоны для разработчиков, которые хотят упаковать своё приложение для магазина [AdminService.Cloud](../../../asc-platform) или кастомного реестра.

## 📂 Что внутри

| Пример | Описание |
|---|---|
| `helloworld/` | 👋 Минимальное Docker-приложение: один `asc.yaml` |
| `nginx/` | 🌐 Веб-сервер Nginx с закреплённой версией релиза и `asc.settings.yaml` (настройки, квоты) |
| `nginx-utility/` | 🧰 Nginx как одноразовая Docker-утилита (`type: utility`), без постоянного сервиса |
| `cs2/` | 🎮 Стек Counter-Strike 2 (`asc.stack.yaml`): выделенный сервер с установкой игры в приватном томе инстанса |
| `7dtd/` | 🧟 Выделенный сервер 7 Days to Die: все env-переменные образа отражены в настройках, включая `enum` с `allow_custom` |

## 🚀 Как попробовать

```bash
# установка примера из локального каталога
asc source add file:///path/to/asc-example-apps
asc install helloworld
asc app logs helloworld
```

## ✍️ Как упаковать своё приложение

1. 📝 Создайте `asc.yaml` в корне репозитория (формат — [📦 package-manager](../../../asc-daemon/docs/package-manager.md)).
2. 🧪 Проверьте локально: `asc source add file://... && asc install <name>`.
3. 🛍️ Опубликуйте: PR в [официальный реестр](../../../registry) или подключите свой GitHub-репозиторий прямо в платформе.

## 🧩 Несколько приложений в одном репозитории (asc.stack.yaml)

Один репозиторий может содержать **несколько приложений** (несколько `asc.yaml` в подкаталогах) — но в корне обязан лежать **ровно один** манифест: либо `asc.yaml`, либо `asc.stack.yaml`, соединяющий все вложенные. Стек `asc.stack.yaml` перечисляет приложения и пути к их `asc.yaml`:

```yaml
name: my-stack
version: 1.0.0
apps:
  - name: web
    path: ./web        # каталог с asc.yaml
  - name: worker
    path: ./worker
```

- 📦 `asc install my-stack` — установка всего стека целиком;
- 🎯 `asc install my-stack/web` — установка только одного приложения из стека;
- 🔗 стек может объявлять общие `env` и порядок запуска приложений.

Подробнее — в [📦 package-manager](../../../asc-daemon/docs/package-manager.md).

## 📚 Документация и Roadmap

- [📦 Формат asc.yaml и реестров](../../../asc-daemon/docs/package-manager.md)
- [🛍️ Магазин приложений](../../../asc-platform/docs/features/app-store.md)
- [🎯 ROADMAP](../../../asc-platform/ROADMAP.md) — задача примеров: `REG-002`

> ⚠️ Каталог `old/` — прошлые наработки, используется как справка.

## 📄 Лицензия

MIT — см. [LICENSE](../../LICENSE). `asc install` показывает эту лицензию и спрашивает согласие один раз на репозиторий перед установкой любого примера отсюда.
