#!/usr/bin/bash

ID=""
REVISION=""

parseResponse(){
	ID=$(echo $1 | jq -r .id)
	REVISION=$(echo $1 | jq -r .revision)
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
parseResponse $R

echo "##################### Delete #######################"
./delete_advisory.sh author2 $ID $REVISION
