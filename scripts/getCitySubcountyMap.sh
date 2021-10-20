#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
#  get city to subcounty map 
#
# Exit on first error, print all commands.
set -e

API_URL="http://localhost:8081"

echo '============'
echo ' RESO UPI Service'
echo '============'
echo '' 
echo 'Sending to API Server at: '$API_URL

TARGET_CREDENTIAL=urn:reso:upi:credentialId:999888777667

METHOD=citySubcountyMap
TARGET_FILE=./map.json
echo '---' 
echo 'Scenario #1: Return the City to Subcounty map currently being used for CA' 
echo ' API Method: '$METHOD
echo '---' 
TARGET_STATE=CA
curl -H "X-Api-Key: "$TARGET_CREDENTIAL $API_URL"/"$METHOD?stateOrProvince=$TARGET_STATE --silent --output $TARGET_FILE
echo ''

METHOD=citySubcountyTable
TARGET_FILE=./map.csv
echo '---' 
echo 'Scenario #2: Return a table of states, cities and subcounties currently being used' 
echo '---' 
curl -H "X-Api-Key: "$TARGET_CREDENTIAL $API_URL"/"$METHOD --silent --output $TARGET_FILE 
echo 'Complete'
echo '' 
 
echo '' 

