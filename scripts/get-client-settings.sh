#!/bin/sh
if [ $# -lt 1 ]; then
    echo "Usage: $0 <short_id>"
    exit 1
fi

echo "IP Address: $(curl -s ifconfig.me)"
echo "UUID: $(cat config/clients/${1}/uuid)"
echo "Public key: $(cat config/public)"
echo "SNI: ${SNI}"
echo "ShortID: ${1}"
echo "Client nickname: $(cat config/clients/${1}/nickname)"
