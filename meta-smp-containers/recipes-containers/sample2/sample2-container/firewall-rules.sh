#!/bin/sh -e
echo "Accepting input/output on local sample2 interface"

iptables -A INPUT   -i ve-sample2 -j ACCEPT
iptables -A OUTPUT  -o ve-sample2 -j ACCEPT
iptables -A FORWARD -i ve-sample2 -j ACCEPT
iptables -A FORWARD -o ve-sample2 -j ACCEPT
