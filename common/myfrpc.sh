#!/bin/sh

. /etc/myrouter/secrets.env

case $1 in
 start)
   frpc verify -c /etc/myrouter/frpc.toml || exit 1

   killall frpc
   frpc -c /etc/myrouter/frpc.toml &
   echo $! > /var/run/myrouter-frpc.pid ;
   ;;
 stop)
   killall frpc
   kill `cat /var/run/myrouter-frpc.pid` ;;
 *)
   echo "usage: myfrpc {start|stop}" ;;
esac
exit 0
