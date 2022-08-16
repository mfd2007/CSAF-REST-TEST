#!/usr/bin/bash

USER=$1
ID=$2
REVISION=$3
STATE=$4

ACCESS_TOKEN=$(cat $USER.access.token) 

URL="http://localhost:8081/api/v1/advisories/"$ID"/workflowstate/"$STATE"?revision="$REVISION \
res=$(
curl -X 'PATCH' \
  -v \
  $URL \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H 'accept: */*') 


echo $res