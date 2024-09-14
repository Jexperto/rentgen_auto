#!/bin/sh
rm -rf /opt/xray/config/*
echo "The proxy-server will be restarted. Config will be reset on startup"
killall /opt/xray/xray 
