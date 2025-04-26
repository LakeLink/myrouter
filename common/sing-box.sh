#!/bin/sh

case $1 in
 start)
   sing-box merge /var/run/sing-box.json \
     -D /root/myrouter \
     -c sing-box.base.json \
     -c sing-box.secrets.json

   sing-box check -c /var/run/sing-box.json || exit 1

   ntpd -dnq -p ntp.sjtu.edu.cn -p time.apple.com -p time.windows.com -p time.cloudflare.com > /var/log/myrouter-ntp.log 2>&1

   killall -9 sing-box
   tmux new-session -d -s "sing-box" "sing-box -c /var/run/sing-box.json run"
   echo `tmux list-panes -F '#{pane_pid}' -t sing-box` > /var/run/myrouter-sing-box.pid ;
   ;;
 stop)
   kill -9 `cat /var/run/myrouter-sing-box.pid`
   ;;
 *)
   echo "usage: sing-box {start|stop}" ;;
esac
exit 0
