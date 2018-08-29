#!/bin/bash

gcloud container clusters list

gke=true;

while $gke; do

echo "Available zones in the US"
cat GKE-zone-list

read -p 'Enter Zone Name from the list: ' zoneName

read -p 'Enter the Cluster Name: ' clusterName

gcloud container clusters create $clusterName --zone $zoneName --num-nodes=1

gcloud container node-pools delete default-pool --cluster $clusterName --zone $zoneName

read -p "Do you want to create NodePool [y/n] " npStatus

npCreation=true;

while $npCreation;do

if [ $npStatus ];then

	if [ $npStatus == 'y' ]; then
                read -p 'Enter the NodePool Name: ' npName
		read -p 'Enter the Node label as K/V pair(example: key=value): ' kvPair
		cat machine-types
		read -p 'Enter the Suitable Machine-Type from the list: ' mType
		cat image-types
		read -p 'Enter the Suitable Image-Type from the list: ' imageType
		read -p 'Enter the number of nodes for NP: ' nodes
		gcloud container node-pools create $npName --cluster $clusterName --zone $zoneName --machine-type=$mType --image-type=$imageType --node-labels=$kvPair --num-nodes=$nodes
	elif [ $npstatus == 'n' ]; then
	        exit 0;
	fi
else

   echo  "Enter a valid response y or n ";
   npCreation=true;

fi

read -p "Do you want to create another NodePool [y/n]" npAnother
if [ $npAnother ];then
	if [ $npAnother == 'y' ]; then
	        npCreation=true;
	   elif [ $npAnother == 'n' ]; then
                npCreation=false;
        fi
else

   echo  "Enter a valid response y or n ";
   npCreation=true;

fi

done

read -p "Do you want initiate another new cluster [y/n] " status

if [ $status ];then

	if [ $status == 'y' ]; then
	   gke=true;
	elif [ $status == 'n' ]; then
	   gke=false;
	else
	   echo  "Enter a valid response y or n ";
	   gke=true;
	fi
fi

done
