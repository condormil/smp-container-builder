#!/bin/sh -e
echo "Accepting input/output on local sample1 interface"

iptables -A INPUT   -i ve-sample1 -j ACCEPT
iptables -A OUTPUT  -o ve-sample1 -j ACCEPT
iptables -A FORWARD -i ve-sample1 -j ACCEPT
iptables -A FORWARD -o ve-sample1 -j ACCEPT
