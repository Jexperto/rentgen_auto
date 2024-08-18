#!/bin/sh
echo "Reloading config..."
killall /opt/xray/xray
/opt/xray/xray run -config /opt/xray/config/config.json
