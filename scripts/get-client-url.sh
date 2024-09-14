#!/bin/sh
if [ $# -lt 1 ]; then
    echo "Usage: $0 <short_id>"
    exit 1
fi

EXT_IP=$(curl -s ifconfig.me)
UUID=$(cat config/clients/${1}/uuid)
NICKNAME=$(cat config/clients/${1}/nickname)
PUB_KEY=$(cat config/public)

echo "vless://${UUID}@${EXT_IP}:443?security=reality&encryption=none&pbk=${PUB_KEY}&headerType=none&fp=chrome&type=tcp&flow=xtls-rprx-vision&sni=${SNI}&sid=${1}#${NICKNAME}"
