#!/usr/bin/bash

ID=""
REVISION=""

parseResponse(){
	ID=$(echo $1 | jq -r .id)
	REVISION=$(echo $1 | jq -r .revision)
}


printResponse(){
echo "******************** RESPONSE *******************************"
echo $1 
echo "*************************************************************"
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
printResponse $R
parseResponse $R

echo "########################################################"
echo "###############Change Status Draft -> Review #######################"
echo "########################################################"
R=$(./changeStatus.sh author2 $ID $REVISION Review)
printResponse $R

echo "########################################################"
echo "############# Add Comment #######################"
echo "########################################################"
R2=$(./post_comment.sh reviewer $ID 9937e70b-a6f8-430e-ab6a-10db33a051a8 category)
printResponse $R2
#parseResponse $R

echo "########################################################"
echo "##################### List Comment #######################"
echo "########################################################"
R=$(./get_comments.sh reviewer $ID)
printResponse $R

echo "########################################################"
echo "##################### Review -> Draft #######################"
echo "########################################################"
R=$(./changeStatus.sh reviewer $ID $REVISION Draft)
printResponse $R

echo "########################################################"
echo "##################### List comment #######################"
echo "########################################################"
R=$(./get_comments.sh author2 $ID)
printResponse $R
#echo "##################### Delete #######################"
#./delete_advisory.sh author2 $ID $REVISION
