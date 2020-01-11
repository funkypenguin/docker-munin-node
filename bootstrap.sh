#!/bin/bash

MUNIN_CONFIGURATION_FILE=/etc/munin/munin-node.conf
MUNIN_LOG_FILE=/var/log/munin/munin-node-configure.log
MUNIN_PID_FILE=/var/run/munin/munin-node.pid

if [ ! -z "$ALLOW" ]; then
    if [ ! -f $MUNIN_CONFIGURATION_FILE.applied ]; then
        echo $ALLOW >> $MUNIN_CONFIGURATION_FILE
        touch $MUNIN_CONFIGURATION_FILE.applied
    fi        
fi

# if /var/lib/muninplugins/ do exist, soft link to /etc/munin/plugins
for i in `ls /var/lib/muninplugins/`; do 
  ln -s /var/lib/muninplugins/$i /etc/munin/plugins/$i
done

if [ -f MUNIN_PID_FILE ]; then
    rm $MUNIN_PID_FILE
fi

/etc/init.d/munin-node start
tailf $MUNIN_LOG_FILE
