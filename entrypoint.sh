FROM ghcr.io/xtls/xray-core:latest AS xray-bin
FROM openresty/openresty:alpine-fat
...
COPY --from=xray-bin /usr/bin/xray /usr/local/bin/xray
