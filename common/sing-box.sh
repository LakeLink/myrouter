#!/bin/sh

case $1 in
 start)
   sing-box merge /var/run/sing-box.json \
     -D /root/myrouter \
     -c sing-box.base.json \
     -c sing-box.dns.json \
     -c sing-box.secrets.json || exit 1

   sing-box check -c /var/run/sing-box.json || exit 2
   killall -9 sing-box
   tmux new-session -d -s "sing-box" "sing-box -c /var/run/sing-box.json run"
   echo `tmux list-panes -F '#{pane_pid}' -t sing-box` > /var/run/myrouter-sing-box.pid ;

   # You might need sing-box up and running to resolve hostname
   ntpd -dnq -p time.apple.com -p time.windows.com -p ntp1.aliyun.com > /var/log/myrouter-ntp.log 2>&1
   ;;
 stop)
   kill -9 `cat /var/run/myrouter-sing-box.pid`
   ;;
 *)
   echo "usage: sing-box {start|stop}" ;;
esac
exit 0
