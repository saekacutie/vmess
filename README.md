# vmess — VMess-WS behind OpenResty (Cloud Run)

Docker image serving **VMess over WebSocket** through OpenResty on Cloud Run,
using Xray-core as the backend.

```
client ──TLS──> :8080 (openresty) ──/vmess-ws──> 127.0.0.1:10000 (xray, vmess)
```

## Files

| File | Purpose |
|---|---|
| `Dockerfile` | Multi-stage build (xray binary + openresty) |
| `xray-config.json` | Xray inbound: vmess, ws, path `/vmess-ws`, port 10000 |
| `nginx.conf` | OpenResty: `listen 8080`, proxies `/vmess-ws` → xray |
| `entrypoint.sh` | Starts openresty (health-checked), then xray |
| `deploy-vm.sh` | Interactive GCP deployer |

## Deploy

```bash
chmod +x deploy-vm.sh
./deploy-vm.sh
```

## Client

- Address: your Cloud Run URL (port 443)
- Path: `/vmess-ws`
- UUID: as printed by the deployer
