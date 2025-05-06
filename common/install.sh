#!/bin/sh

cd /root/myrouter
chmod +x *.sh

rm /etc/monitrc
ln -s /root/myrouter/monitrc-common /etc/monitrc
chmod 600 /etc/monitrc

mkdir -p /etc/monit.d
ln -s /root/myrouter/monitrc-myrouter /etc/monit.d/10-myrouter

/etc/init.d/monit restart

