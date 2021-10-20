#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
# build a UPI 
#
# Exit on first error, print all commands.
set -e

API_URL="http://localhost:8081"
METHOD=upi/build

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' API Method: '$METHOD
echo '============'
echo '' 
echo 'Sending to API Server at: '$API_URL

TARGET_CREDENTIAL=urn:reso:upi:credentialId:999888777667

echo '---' 
echo 'Scenario #1: Build a upi with seperate state and county' 
echo '---' 
TARGET_COUNTRY=US
TARGET_STATE=VT
#TARGET_COUNTY=013
TARGET_COUNTY="Grand+Isle+County"
#TARGET_SUBCOUNTY=50650
TARGET_SUBCOUNTY="North+Hero"
TARGET_PARCEL=666777888
TARGET_PROPERTY_TYPE=R
TARGET_SUB_PROPERTY=N
DATA={\
\"country\":\"$TARGET_COUNTRY\",\
\"state\":\"$TARGET_STATE\",\
\"county\":\"$TARGET_COUNTY\",\
\"subcounty\":\"$TARGET_SUBCOUNTY\",\
\"parcel\":\"$TARGET_PARCEL\",\
\"propertyType\":\"$TARGET_PROPERTY_TYPE\",\
\"subproperty\":\"$TARGET_SUB_PROPERTY\"\
}
echo $DATA
curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

echo '---' 
echo 'Scenario #2: Build a upi with seperate state and county and no subcounty' 
echo '---' 
TARGET_COUNTRY=US
TARGET_STATE=VT
#TARGET_COUNTY=013
TARGET_COUNTY="Grand+Isle+County"
TARGET_SUBCOUNTY=00000
TARGET_PARCEL=666777888
TARGET_PROPERTY_TYPE=R
TARGET_SUB_PROPERTY=N
DATA={\
\"country\":\"$TARGET_COUNTRY\",\
\"state\":\"$TARGET_STATE\",\
\"county\":\"$TARGET_COUNTY\",\
\"subcounty\":\"$TARGET_SUBCOUNTY\",\
\"parcel\":\"$TARGET_PARCEL\",\
\"propertyType\":\"$TARGET_PROPERTY_TYPE\",\
\"subproperty\":\"$TARGET_SUB_PROPERTY\"\
}
echo $DATA
curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

echo '---' 
echo 'Scenario #3: Build a upi with seperate state and county and no subcounty where subcounty exists' 
echo '---' 
TARGET_COUNTRY=US
TARGET_STATE=CA
#TARGET_COUNTY=075
TARGET_COUNTY="San+Francisco"
TARGET_SUBCOUNTY=00000
TARGET_PARCEL=5843020
TARGET_PROPERTY_TYPE=R
TARGET_SUB_PROPERTY=N
DATA={\
\"country\":\"$TARGET_COUNTRY\",\
\"state\":\"$TARGET_STATE\",\
\"county\":\"$TARGET_COUNTY\",\
\"subcounty\":\"$TARGET_SUBCOUNTY\",\
\"parcel\":\"$TARGET_PARCEL\",\
\"propertyType\":\"$TARGET_PROPERTY_TYPE\",\
\"subproperty\":\"$TARGET_SUB_PROPERTY\"\
}
echo $DATA
curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

echo '---' 
echo 'Scenario #4: Build a upi with fips using API short form' 
echo '---' 
TARGET_COUNTRY=US
TARGET_FIPS=50013
TARGET_SUBCOUNTY=50650
TARGET_PARCEL=666777888
TARGET_PROPERTY_TYPE=R
TARGET_SUB_PROPERTY=N
DATA={\
\"country\":\"$TARGET_COUNTRY\",\
\"fips\":\"$TARGET_FIPS\",\
\"subcounty\":\"$TARGET_SUBCOUNTY\",\
\"parcel\":\"$TARGET_PARCEL\",\
\"propertyType\":\"$TARGET_PROPERTY_TYPE\",\
\"subproperty\":\"$TARGET_SUB_PROPERTY\"\
}
#echo $DATA
curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

echo '---' 
echo 'Scenario #5: Build a upi with seperate state and county and a reference' 
echo '---' 
TARGET_COUNTRY=US
TARGET_STATE=VT
#TARGET_COUNTY=013
TARGET_COUNTY="Grand+Isle+County"
TARGET_SUBCOUNTY="North+Hero"
TARGET_PARCEL=666777888
TARGET_PROPERTY_TYPE=R
TARGET_SUB_PROPERTY=N
TARGET_REFERENCE=listingid001
DATA={\
\"country\":\"$TARGET_COUNTRY\",\
\"state\":\"$TARGET_STATE\",\
\"county\":\"$TARGET_COUNTY\",\
\"subcounty\":\"$TARGET_SUBCOUNTY\",\
\"parcel\":\"$TARGET_PARCEL\",\
\"propertyType\":\"$TARGET_PROPERTY_TYPE\",\
\"subproperty\":\"$TARGET_SUB_PROPERTY\",\
\"reference\":\"$TARGET_REFERENCE\"\
}
echo $DATA
curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

echo '---' 
echo 'Scenario #6: Build a upi with seperate state and county with a subcounty that does not exist' 
echo '---' 
TARGET_COUNTRY=US
TARGET_STATE=CA
TARGET_COUNTY="San+Mateo"
TARGET_SUBCOUNTY="Daly+City"
TARGET_PARCEL=091-283-160
TARGET_PROPERTY_TYPE=R
TARGET_SUB_PROPERTY=N
DATA={\
\"country\":\"$TARGET_COUNTRY\",\
\"state\":\"$TARGET_STATE\",\
\"county\":\"$TARGET_COUNTY\",\
\"subcounty\":\"$TARGET_SUBCOUNTY\",\
\"parcel\":\"$TARGET_PARCEL\",\
\"propertyType\":\"$TARGET_PROPERTY_TYPE\",\
\"subproperty\":\"$TARGET_SUB_PROPERTY\"\
}
echo $DATA
curl -d $DATA -H "X-Api-Key: "$TARGET_CREDENTIAL -H "Content-Type: application/json" -X POST $API_URL/$METHOD
echo ''

echo ''

