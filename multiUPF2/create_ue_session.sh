#!/bin/bash

NumberOfGNBInstances=1
NumberOfUEInstances=2
UEsCreatedAtTheSameTime=1
UE_IMSI=208930000000003
ContainerName=ueransim


for ((i=1;i<=$NumberOfGNBInstances;i++));
do    
   echo "Start $NumberOfUEInstances UE instances"
   UEsCreated=0
   for((j=0; j<NumberOfUEInstances;j=j+UEsCreatedAtTheSameTime))
   do   
	variable_name=UE_IMSI$(($j+1))
	UE_IMSI=${!variable_name}
	docker exec $ContainerName ./build/nr-ue -c config/ue$(($j+1)).yaml  -n $UEsCreatedAtTheSameTime&
        #docker exec $ContainerName ./build/nr-ue -c config/ue.yaml -i imsi-${UE_IMSI} -n $UEsCreatedAtTheSameTime&
        UE_IMSI=$((UE_IMSI+UEsCreatedAtTheSameTime))
        UEsCreated=$((UEsCreated+UEsCreatedAtTheSameTime))
        sleep 2
    done
done
echo "all UEs started"

