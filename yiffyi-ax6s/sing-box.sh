#!/bin/sh

case $1 in
 start)
   sing-box merge sing-box.json \
     -D /root/myrouter \
     -c sing-box.base.json \
     -c sing-box.secrets.json

   killall -9 sing-box
   tmux new-session -d -s "sing-box" "sing-box -c /root/myrouter/sing-box.json run"
   echo `tmux list-panes -F '#{pane_pid}' -t sing-box` > /var/run/myrouter-sing-box.pid ;
   ;;
 stop)
   kill -9 `cat /var/run/myrouter-sing-box.pid`
   ;;
 *)
   echo "usage: sing-box {start|stop}" ;;
esac
exit 0
