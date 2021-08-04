#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
# parse a UPI 
#
# Exit on first error, print all commands.
set -e

API_URL="http://localhost:8081"
METHOD=upi/parse

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' API Method: '$METHOD
echo '============'
echo '' 
echo 'Sending to API Server at: '$API_URL

TARGET_CREDENTIAL=urn:reso:upi:credentialId:999888777667

echo '---' 
echo 'Scenario #1: parse a upi' 
echo '---' 
TARGET_UPI=US-50013-50650-666777888-R-N
echo 'Parcing UPI' $TARGET_UPI

#
# JSON Encoded
#
DATA={\
\"upi\":\"$TARGET_UPI\"\
}
#echo $DATA
curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

echo ''

