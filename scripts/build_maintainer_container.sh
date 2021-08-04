#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
# Build the container from the mainter repository 
#
# Exit on first error, print all commands.
set -e

REPOSITORY_NAME="lesswing.com:8443"
IMAGE_NAME="reso-upi-service-container"

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' Build a container' 
echo '============'
echo '' 
echo ' Repository name: '$REPOSITORY_NAME
echo ' Image name: '$IMAGE_NAME
echo '' 

docker run --detach \
  --name $IMAGE_NAME \
  --restart=always \
  --publish 8081:8081 \
  $REPOSITORY_NAME/$IMAGE_NAME \
  npm start

echo '' 

