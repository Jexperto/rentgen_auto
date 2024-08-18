#!/bin/sh
rm -rf config/.lockfile
echo "The proxy-server will be restarted. Config will be reset on startup"
killall /opt/xray/xray 
