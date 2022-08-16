#!/usr/bin/bash

USER=$1

ACCESS_TOKEN=$(cat $USER.access.token)  

R=$(curl -H "Authorization: Bearer $ACCESS_TOKEN" \
	 -H 'Content-Type: application/json' \
	 -v \
	 http://localhost:8081/api/v1/advisories
)

echo $R | jq