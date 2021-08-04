#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
#  Check running version 
#
# Exit on first error, print all commands.
set -e

API_URL="http://localhost:8081"
METHOD=version

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' API Method: '$METHOD
echo '============'
echo '' 
echo 'Sending to API Server at: '$API_URL

echo '---' 
echo 'Scenario #1: Return the build version of the API Server' 
echo '---' 
echo -n 'Version: '
curl $API_URL"/"$METHOD
echo '' 
echo '' 

