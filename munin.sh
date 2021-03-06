#!/usr/bin/env bash

# Change to script directory
sd=`dirname $0`
cd $sd

# Install Munin
apt-get install -y munin

# Configure directories
echo "dbdir /var/lib/munin" >> /etc/munin/munin.conf
echo "htmldir /var/cache/munin/www" >> /etc/munin/munin.conf
echo "logdir /var/log/munin" >> /etc/munin/munin.conf
echo "rundir /var/run/munin" >> /etc/munin/munin.conf
echo "tmpldir /etc/munin/templates" >> /etc/munin/munin.conf

# Configure munin node (https://github.com/redgeoff/munin-node-vagrant)
echo "[MuninNode]" >> /etc/munin/munin.conf
echo "  address 192.168.50.20" >> /etc/munin/munin.conf
echo "  use_node_name yes" >> /etc/munin/munin.conf

# Change name of main tree
sed -i "s'localhost.localdomain'MuninMaster'" /etc/munin/munin.conf

# Configure authentication passwords
cp munin-htpasswd /etc/munin/munin-htpasswd

# Restart nginx and Munin
service nginx restart
service munin-node restart
