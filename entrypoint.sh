#!/bin/sh

export BAIDUPCS_GO_CONFIG_DIR=/config

if [[ -f "${BAIDUPCS_GO_CONFIG_DIR}/pcs_config.json" ]]; then
  /usr/bin/baidupcs web --access &> /config/server.log
  tail -f /config/server.log
else
  echo "Configuration file not found."
  exit 1
fi
