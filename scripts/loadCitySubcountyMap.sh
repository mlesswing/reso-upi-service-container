#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
# Load City to Suncounty MAp 
#
# Exit on first error, print all commands.
set -e

API_URL="http://localhost:8081"

echo '============'
echo ' RESO UPI Service'
echo '' 
echo '============'
echo '' 
echo 'Sending to API Server at: '$API_URL

TARGET_CREDENTIAL=urn:reso:upi:credentialId:999888777667

METHOD=loadCitySubcountyMap
echo '---' 
echo 'Scenario #1: load map' 
echo ' API Method: '$METHOD
echo '---' 

DATA={\"timestamp\":1634059419871,\"stateOrProvince\":\"CA\",\"cityNames\":[\"San+Francisco\",\"Hayward\",\"South+San+Francisco\",\"Pittsburg\",\"Sacramento\",\"San+Jose\",\"Antioch\",\"Vallejo\",\"Oakland\",\"Half+Moon+Bay\",\"Marysville\",\"South+Lake+Tahoe\",\"San+Mateo\",\"Santa+Clara\",\"Berkeley\",\"Daly+City\",\"Pacifica\",\"San+Leandro\",\"Belmont\",\"Foster+City\",\"Brisbane\",\"Richmond\",\"San+Bruno\",\"Concord\",\"Burlingame\",\"Millbrae\",\"Redwood+City\",\"Orinda\",\"Castro+Valley\",\"San+Carlos\",\"Hillsborough\",\"Walnut+Creek\",\"Valley+Springs\",\"Woodside\",\"Pinole\",\"Greenbrae\",\"Newark\",\"Colma\"],\"subcountyCodes\":[\"92790\",\"91260\",\"93170\",\"90080\",\"92690\",\"92830\",\"90080\",\"93530\",\"92230\",\"91215\",\"91900\",\"93160\",\"92870\",\"93175\",\"90200\",\"93170\",\"93170\",\"91260\",\"92870\",\"92870\",\"93170\",\"93620\",\"93170\",\"90440\",\"93170\",\"93170\",\"92870\",\"90440\",\"91260\",\"92870\",\"92870\",\"90440\",\"92740\",\"92870\",\"93620\",\"92670\",\"91070\",\"93170\"]}

#echo $DATA
#curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

METHOD=loadCitySubcountyTable
echo '---' 
echo 'Scenario #2: load table' 
echo ' API Method: '$METHOD
echo '---' 
TARGET_FILE=map.csv

DATA={\"fileName\":\"$TARGET_FILE\"}

echo $DATA
curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

echo ''

