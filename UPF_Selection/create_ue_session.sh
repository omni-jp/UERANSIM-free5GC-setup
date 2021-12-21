#!/bin/bash
UE_ID=$1
ContainerName=ueransim

docker exec $ContainerName ./build/nr-ue -c config/ue${UE_ID}.yaml&
sleep 2

echo "UE${UEID} started"

