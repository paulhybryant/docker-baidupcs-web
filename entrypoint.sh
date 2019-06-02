#!/bin/sh

/usr/bin/baidupcs web --access &> /config/server.log
tail -f /config/server.log
