#!/bin/sh

cd /root/myrouter
#nft delete table inet myrouter
nft -f $1 -I .
