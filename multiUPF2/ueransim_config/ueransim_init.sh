#!/bin/bash

export IP_ADDR=$(awk 'END{print $1}' /etc/hosts)
echo
echo "gNB IP Address:${IP_ADDR}"
echo

cp /mnt/ueransim/gnb.yaml /UERANSIM/config/gnb.yaml
cp /mnt/ueransim/ue*.yaml /UERANSIM/config/.

echo "Change gNB config entries"
sed -i -e "s/MCC/${MCC}/g" /UERANSIM/config/gnb.yaml
sed -i -e "s/MNC/${MNC}/g" /UERANSIM/config/gnb.yaml

sed -i -e "s/GNB_N2_IP/${IP_ADDR}/g" /UERANSIM/config/gnb.yaml
sed -i -e "s/GNB_N3_IP/${IP_ADDR}/g" /UERANSIM/config/gnb.yaml

sed -i -e "s/NSSAI_SST1/${NSSAI_SST1}/g" /UERANSIM/config/gnb.yaml
sed -i -e "s/NSSAI_SD1/${NSSAI_SD1}/g" /UERANSIM/config/gnb.yaml
sed -i -e "s/NSSAI_SST2/${NSSAI_SST2}/g" /UERANSIM/config/gnb.yaml
sed -i -e "s/NSSAI_SD2/${NSSAI_SD2}/g" /UERANSIM/config/gnb.yaml

sed -i -e "s/GNB_AMF_IP/${GNB_AMF_IP}/g" /UERANSIM/config/gnb.yaml
sed -i -e "s/TAC/${TAC}/g" /UERANSIM/config/gnb.yaml

echo "Change UE config entries"
sed -i -e "s/MCC/${MCC}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/MNC/${MNC}/g" /UERANSIM/config/ue*.yaml

sed -i -e "s/GNB_N2_IP/${IP_ADDR}/g" /UERANSIM/config/ue*.yaml

sed -i -e "s/NSSAI_SST1/${NSSAI_SST1}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/NSSAI_SD1/${NSSAI_SD1}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/NSSAI_SST2/${NSSAI_SST2}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/NSSAI_SD2/${NSSAI_SD2}/g" /UERANSIM/config/ue*.yaml

sed -i -e "s/UE_IMEI/${UE_IMEI}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/UE_IMSI1/${UE_IMSI1}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/UE_IMSI2/${UE_IMSI2}/g" /UERANSIM/config/ue*.yaml

sed -i -e "s/UE_KEY/${UE_KEY}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/UE_OP/${UE_OP}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/UE_AMF_AUTH/${UE_AMF_AUTH}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/APN_NAME1/${APN_NAME1}/g" /UERANSIM/config/ue*.yaml
sed -i -e "s/APN_NAME2/${APN_NAME2}/g" /UERANSIM/config/ue*.yaml


echo "Start UE-RANSIM"
./build/nr-gnb -c config/gnb.yaml
