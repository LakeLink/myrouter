#!/bin/sh

. /root/myrouter/secrets.env

case $1 in
 start)
   ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=10 -o PasswordAuthentication=no \
   -R :80:127.0.0.1:22 \
   -p $FRP_SERVER_PORT v0@$FRP_SERVER_ADDR \
   stcp --token $FRP_SERVER_TOKEN --user $FRP_USER_NAME --proxy-name $FRP_BACKDOOR_PROXY_NAME --sk $FRP_BACKDOOR_SECRET &

   echo $! > /var/run/myrouter-ssh.pid ;
   ;;
 stop)
   kill `cat /var/run/myrouter-ssh.pid` ;;
 *)
   echo "usage: backdoor {start|stop}" ;;
esac
exit 0
