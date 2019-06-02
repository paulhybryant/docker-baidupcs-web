#!/bin/sh

BAIDUPCS_GO_CONFIG_DIR=/config

/usr/bin/baidupcs web --access &> /config/server.log
tail -f /config/server.log
