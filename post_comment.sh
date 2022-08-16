#!/usr/bin/bash

USER=$1
ID=$2
NODE=$3
FIELD=$4

ACCESS_TOKEN=$(cat $USER.access.token) 

DATA="{\"commentText\": \"This is a comment\", \"csafNodeId\": \"$NODE\", \"fieldName\": \"$FIELD\"}"

res=$(curl -X 'POST' \
  "http://localhost:8081/api/v1/advisories/"$ID"/comments" \
  -v \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'accept: */*' \
  --data @- <<END;
$DATA
END
)

echo $res

