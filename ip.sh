#!/bin/bash
IP=`ifconfig | grep "inet addr:17" | cut -f2 -d ":" | cut -f1 -d " "`

echo $IP > /tmp/ip.txt
