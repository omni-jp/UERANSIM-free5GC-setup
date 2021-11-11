#!/bin/bash

export IP_ADDR=$(awk 'END{print $1}' /etc/hosts)
echo
echo "gNB IP Address:${IP_ADDR}"
echo

CIDR_ARR=($CIDRS)

for cidr in "${CIDR_ARR[@]}"
do
 iptables -t nat -A POSTROUTING -s $cidr ! -o upfgtp -j MASQUERADE  
done

./free5gc-upfd -f ../config/upfcfg.yaml
