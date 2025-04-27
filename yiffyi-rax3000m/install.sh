#!/bin/sh

cd /root/myrouter
chmod +x *.sh

mv /root/myrouter/monitrc /etc/monitrc
mkdir -p /etc/monit.d
ln -s /root/myrouter/myrouter-monitrc /etc/monit.d/10-myrouter

/etc/init.d/monit restart

