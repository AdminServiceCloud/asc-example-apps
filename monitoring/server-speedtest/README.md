# 🚀 server-speedtest

[statebyte/server-speedtest](https://github.com/statebyte/server-speedtest):
a self-hosted network speed test measured directly against this server —
download, upload, latency, jitter, packet loss and a channel quality score,
plus a map of the great-circle path between server and client.

## 🚀 Install

```bash
asc source add file:///path/to/asc-example-apps
asc install server-speedtest
asc app start server-speedtest
```

Open the published port (default `3000`).

## 📖 What it demonstrates

- a **large `type: ports` list** (`ice_ports`, the full 100-port WebRTC ICE
  UDP range) alongside two plain `number` settings (`ice_port_min`/
  `ice_port_max`) that must be kept in sync with it — the app needs the
  numeric range for its own WebRTC stack, ASC needs every individual port
  published (host port == container port, one binding per list entry);
  changing the range means updating both;
- optional metadata/privacy toggles (`server_hostname`, `server_public_ip`,
  `hide_server_ip`, `hide_server_asn`) left unset by default.
