#!/usr/bin/bash

USER=$1
ID=$2
REVISION=$3
FILE=$4

ACCESS_TOKEN=$(cat $USER.access.token) 

DATA=$(cat $FILE)

res=$(curl -X 'PATCH' \
  'http://localhost:8081/api/v1/advisories/'$ID'?revision='$REVISION \
  -sw "%{http_code}" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  -H 'accept: */*' \
  -v \
  --data @- <<END;
  $DATA
END
)

echo $res

