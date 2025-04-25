#!/bin/sh

ip rule add fwmark 1100 table 1100 pref 36000
ip route add local default dev lo table 1100

# ip -6 rule add to 240c:c7b9:0:400::/64 table main pref 30000
ip -6 rule add fwmark 1100 table 1100 pref 30010
ip -6 route add local default dev lo table 1100