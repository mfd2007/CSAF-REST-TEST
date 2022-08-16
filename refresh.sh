#!/usr/bin/bash

USER=$1

REFRESH_TOKEN=$(cat $USER.refresh.token)

RES=$(curl -X POST \
	 -d 'client_id=secvisogram' \
	 -d 'client_secret=EDVK2RpRmFUGQrOwI3S0zJEl9SnbajlI' \
	 -d 'grant_type=refresh_token' \
	 -d 'refresh_token='$REFRESH_TOKEN \
	 -H 'Content-Type: application/x-www-form-urlencoded' \
	 -sw "%{http_code}" \
	 http://localhost:9000/realms/csaf/protocol/openid-connect/token)

CODE=${RES:${#RES}-3:${#RES}}
R=${RES:0:${#RES}-3}
 
ACCESS_TOKEN=$(echo $R | jq -r .access_token)
REFRESH_TOKEN=$(echo $R | jq -r .refresh_token)

echo $ACCESS_TOKEN > $USER.access.token
echo $REFRESH_TOKEN > $USER.refresh.token
