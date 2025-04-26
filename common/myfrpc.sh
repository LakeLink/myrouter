#!/bin/sh

. /root/myrouter/secrets.env

case $1 in
 start)
   frpc verify -c /root/myrouter/frpc.toml || exit 1

   killall frpc
   frpc -c /root/myrouter/frpc.toml &
   echo $! > /var/run/myrouter-frpc.pid ;
   ;;
 stop)
   killall frpc
   kill `cat /var/run/myrouter-frpc.pid` ;;
 *)
   echo "usage: myfrpc {start|stop}" ;;
esac
exit 0
