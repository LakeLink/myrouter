#!/bin/sh

cd /root/myrouter
#nft delete table inet myrouter
nft -f firewall.nft -I .
