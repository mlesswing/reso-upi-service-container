#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
#  Discover potential geographic matches 
#
# Exit on first error, print all commands.
set -e

API_URL="http://localhost:8081"
METHOD=upi/discover

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' API Method: '$METHOD
echo '============'
echo '' 
echo 'Sending to API Server at: '$API_URL

echo '---' 
echo 'Scenario #1: Return geographic hints API Server' 
echo '---'
TARGET_HINT=Kane
echo 'Retreiving hints for:' $TARGET_HINT
 
curl $API_URL"/"$METHOD"?hint="$TARGET_HINT
echo ''
 
echo '---' 
echo 'Scenario #2: Return geographic hints API Server' 
echo '---'
TARGET_HINT=Charleston
echo 'Retreiving hints for:' $TARGET_HINT
 
curl $API_URL"/"$METHOD"?hint="$TARGET_HINT
echo ''
 
echo '' 

