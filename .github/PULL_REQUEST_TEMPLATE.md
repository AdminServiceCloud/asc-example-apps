<!--
Thanks for contributing an example app!
Examples are living documentation of the asc.yaml / asc.stack.yaml format. See AGENTS.md.
-->

## 📋 Summary

<!-- What example does this PR add or change? -->

## 🧩 Type of change

- [ ] ➕ New example app
- [ ] ✏️ Update an existing example
- [ ] 🧱 New stack example (`asc.stack.yaml`)
- [ ] 📝 Documentation
- [ ] 🐛 Fix (example doesn't install / build)

## 📦 Example details

- Name:
- Runtime: `docker` / `native` / `utility` / `stack`
- Manifest: `asc.yaml` / `asc.stack.yaml`

## ✅ Checklist

- [ ] Manifest follows the [package-manager doc](../asc-daemon/docs/package-manager.md) and validates against the schemas in [../registry/schema/](../registry/schema/).
- [ ] **Root rule:** the package root contains exactly one `asc.yaml` (single app) **or** one `asc.stack.yaml` (stack joining nested `asc.yaml` files).
- [ ] Each example lives in its own directory with a minimal README (what it is + how to install).
- [ ] The example actually installs: verified with `asc source add file://... && asc install <name>` (once the daemon is available).
- [ ] Comments inside example manifests may be in English (they get copied into international packages).
- [ ] Commits follow Conventional Commits.

## 🔗 Related

- Roadmap task: REG-002
- Closes #

## 🔎 How to test

```bash
asc source add file:///path/to/asc-example-apps
asc install <name>
asc app logs <name>
```

## 📌 Notes

<!-- Anything else reviewers should know. -->
