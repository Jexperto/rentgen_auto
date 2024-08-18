#!/bin/bash

#LOCKFILE for generate uuid and keys in first start
LOCKFILE=config/.lockfile
if [ ! -f $LOCKFILE ]
then
  #generate Public & Private keys
  echo "Generate public & private keys..."
  /opt/xray/xray x25519 > config/keys

  #Create files with Public & Private keys
  awk '/Public/{print $3}' config/keys > config/public
  awk '/Private/{print $3}' config/keys > config/private

  PRIVATE=$(cat config/private)

  #set private key in config.json
  sed -i 's/"privateKey":.*/"privateKey": "'${PRIVATE}'",/' config/config.json

  source scripts/add-client.sh --nickname admin
  #create lockfile
  touch $LOCKFILE
fi

sed -i 's/"dest":.*/"dest": "'${SNI}':443",/' config/config.json
sed -i '/serverNames/{n;s/.*/\t\t\t\t"'${SNI}'"/}' config/config.json

#run proxy
echo "XTLS reality starting..."
/opt/xray/xray run -config /opt/xray/config/config.json
