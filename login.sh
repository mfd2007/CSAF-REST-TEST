#!/usr/bin/bash

USER=$1
PASSWORD=$1


REFRESH_TOKEN=$(cat $USER.refresh.token)

# Try to refresh token
R=$(curl -X POST \
	 -d 'client_id=secvisogram' \
	 -d 'client_secret=EDVK2RpRmFUGQrOwI3S0zJEl9SnbajlI' \
	 -d 'grant_type=refresh_token' \
	 -d 'refresh_token='$REFRESH_TOKEN \
	 -H 'Content-Type: application/x-www-form-urlencoded' \
	 -sw "%{http_code}" \
	 http://localhost:9000/realms/csaf/protocol/openid-connect/token)

CODE=${R:${#R}-3:${#R}}
RES=${R:0:${#R}-3}
echo $CODE

if [ $CODE = "200" ]
then

	echo "refresh"
	ACCESS_TOKEN=$(echo $RES | jq -r .access_token)
	REFRESH_TOKEN=$(echo $RES | jq -r .refresh_token)

	echo $ACCESS_TOKEN > $USER.access.token
	echo $REFRESH_TOKEN > $USER.refresh.token
else
	echo "login"
	R=$(curl -X POST \
	 -d 'client_id=secvisogram' \
	 -d 'client_secret=EDVK2RpRmFUGQrOwI3S0zJEl9SnbajlI' \
	 -d "username="$USER \
	 -d "password="$PASSWORD \
	 -d 'grant_type=password' \
	 -d 'response_type=code' \
	 -d 'audience=secvisogram' \
	 -d 'scope=acr+roles+openid+email+profile' \
	 -d 'requested_token_type=ID' \
	 -H 'Content-Type: application/x-www-form-urlencoded' \
	 -sw "%{http_code}" \
	 -v \
	 http://localhost:9000/realms/csaf/protocol/openid-connect/token)

	CODE=${R:${#R}-3:${#R}}
	RES=${R:0:${#R}-3}

	ACCESS_TOKEN=$(echo $RES | jq -r .access_token)
	REFRESH_TOKEN=$(echo $RES | jq -r .refresh_token)
	
	echo $ACCESS_TOKEN > $USER.access.token
	echo $REFRESH_TOKEN > $USER.refresh.token
fi


