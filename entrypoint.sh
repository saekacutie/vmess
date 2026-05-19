#!/bin/sh
set -e

# Start OpenResty in background
/usr/local/openresty/bin/openresty -g 'daemon off;' &
OPENRESTY_PID=$!

# Give OpenResty time to start
sleep 3

# Check if OpenResty started successfully
if ! kill -0 $OPENRESTY_PID 2>/dev/null; then
    echo "[ERROR] OpenResty failed to start"
    exit 1
fi

echo "[INFO] OpenResty started (PID: $OPENRESTY_PID)"

# Start Xray
exec /usr/local/bin/xray run -c /etc/xray/config.json
