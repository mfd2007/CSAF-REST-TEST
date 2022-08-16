#!/usr/bin/bash

USER=$1
FILE=$2

ACCESS_TOKEN=$(cat $USER.access.token) 

DATA=$(cat $FILE)

res=$(curl -X 'POST' \
  'http://localhost:8081/api/v1/advisories' \
  -sw "%{http_code}" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'accept: */*' \
  -v \
  --data @- <<END;
  $DATA
END
)

echo ${res:0:${#res}-3}

