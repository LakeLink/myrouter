#!/bin/sh

# 998 is used for generic output, used to force reroute
ip rule add fwmark 998 table 998 pref 9000
ip route add local default dev lo table 998

# 999 is used for sing-box output, will be reset in nftable
ip rule add fwmark 1000 table 1000 pref 35000
ip rule add fwmark 1001 table 1001 pref 35000
ip rule add fwmark 1002 table 1002 pref 35000
ip rule add fwmark 1003 table 1003 pref 35000
ip rule add fwmark 1004 table 1004 pref 35000

ip rule add fwmark 1100 table 1100 pref 36000
ip route add local default dev lo table 1100

ip -6 rule add to 240c:c7b9:0:400::/64 table main pref 30000
ip -6 rule add fwmark 1100 table 1100 pref 30010
ip -6 route add local default dev lo table 1100