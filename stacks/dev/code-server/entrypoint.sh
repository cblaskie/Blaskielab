#!/bin/sh
set -e

EXT_FILE="/home/coder/extensions.json"

echo "[code-server] Starting entrypoint"

# Install extensions if file exists
if [ -f "$EXT_FILE" ]; then
  echo "[code-server] Installing extensions"
  xargs -r -n 1 code-server --install-extension < "$EXT_FILE"
else
  echo "[code-server] No extensions file found, skipping"
fi

echo "[code-server] Launching code-server"
exec code-server --bind-addr 0.0.0.0:8080 --disable-telemetry
