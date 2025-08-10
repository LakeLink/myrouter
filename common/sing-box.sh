#!/bin/sh

case $1 in
 start)
   sing-box merge /var/run/sing-box.json \
     -D /etc/myrouter \
     -c sing-box.base.json \
     -c sing-box.dns.json \
     -c sing-box.secrets.json || exit 1

   sing-box check -c /var/run/sing-box.json || exit 2

   tmux capture-pane -p -t sing-box > /var/log/myrouter-sing-box-tail.log
   tmux kill-session -t "sing-box"

   # memory limit: 100MB
   tmux new-session -d -s sing-box -e "GOMEMLIMIT=100000000" "sing-box -c /var/run/sing-box.json run"\; \
        set-option remain-on-exit failed

   tmux list-panes -F '#{pane_pid}' -t sing-box > /var/run/myrouter-sing-box.pid ;

   # You might need sing-box up and running to resolve hostname
   ntpd -dnq -p time.apple.com -p time.windows.com -p ntp1.aliyun.com > /var/log/myrouter-ntp.log 2>&1
   ;;
 stop)
   tmux capture-pane -p -t sing-box > /var/log/myrouter-sing-box-tail.log
   kill -9 `cat /var/run/myrouter-sing-box.pid` && rm /var/run/myrouter-sing-box.pid
   tmux kill-session -t "sing-box"
   ;;
 *)
   echo "usage: sing-box {start|stop}" ;;
esac
exit 0
