#!/bin/sh

cd /root/myrouter
chmod +x *.sh

rm /etc/monitrc
ln -s /root/myrouter/monitrc-common /etc/monitrc
chmod 600 /etc/monitrc

mkdir -p /etc/monit.d
rm /etc/monit.d/10-myrouter
ln -s /root/myrouter/monitrc-myrouter /etc/monit.d/10-myrouter

/etc/init.d/monit restart

rm /etc/netdata/netdata.conf
ln -s /root/myrouter/netdata.conf /etc/netdata/netdata.conf

/etc/init.d/netdata restart
