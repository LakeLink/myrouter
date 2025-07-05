#!/bin/sh

cd /etc/myrouter
#nft delete table inet myrouter
nft -f $1 -I .
