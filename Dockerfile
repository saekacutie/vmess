FROM teddysun/xray:latest AS xray-bin
FROM openresty/openresty:alpine-fat

RUN apk add --no-cache curl

# Copy Xray from builder stage
COPY --from=xray-bin /usr/bin/xray /usr/local/bin/xray
RUN chmod +x /usr/local/bin/xray

# Copy configuration files
COPY xray-config.json /etc/xray/config.json
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Cloud Run requires listening on PORT 8080
EXPOSE 8080

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
