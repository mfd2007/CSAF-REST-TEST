#!/usr/bin/bash

ID=""
REVISION=""

parseResponse(){
	TMP=$(echo $1 | jq -r .id)
	if [ ! $TMP = "null" ]
	then
		ID=$(echo $1 | jq -r .id)
	fi
	REVISION=$(echo $1 | jq -r .revision)
}

status(){
	echo $ID $REVISION
}


echo "########################################################"
echo "########## Login Users ##################"
echo "########################################################"
./login.sh author2
./login.sh reviewer

echo "########################################################"
echo "########## Post advisory ################"
echo "########################################################"
R=$(./post_advisory.sh author2 acme-1.json)

echo $R
parseResponse $R
echo "########################################################"
status
echo "########################################################"
./get_advisory.sh author2 $ID
echo "########################################################"

echo "########################################################"
echo "########## Update advisory 1 ################"
echo "########################################################"
R=$(./patch_advisory.sh author2 $ID $REVISION acme-1_update_1.json)
parseResponse $R
echo "########################################################"
./get_advisory.sh author2 $ID $REVISION

echo "########################################################"
echo "########################################################"
echo "########## Update advisory 2 ################"
echo "########################################################"
R=$(./patch_advisory.sh author2 $ID $REVISION acme-1_update_2.json)
parseResponse $R
./get_advisory.sh author2 $ID $REVISION

echo "##################### Delete #######################"
./delete_advisory.sh author2 $ID $REVISION
