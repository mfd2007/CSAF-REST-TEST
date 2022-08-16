#!/usr/bin/bash

USER=$1
ID=$2

ACCESS_TOKEN=$(cat $USER.access.token)  
URL="http://localhost:8081/api/v1/advisories/"$ID

R=$(curl -H "Authorization: Bearer $ACCESS_TOKEN" \
	 -H 'Content-Type: application/json' \
	 -v \
	 $URL
)

echo $R | jq 