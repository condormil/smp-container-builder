#!/bin/sh -e
echo "Accepting input/output on local sample-www interface"

iptables -A INPUT   -i ve-sample-www -j ACCEPT
iptables -A OUTPUT  -o ve-sample-www -j ACCEPT
iptables -A FORWARD -i ve-sample-www -j ACCEPT
iptables -A FORWARD -o ve-sample-www -j ACCEPT
