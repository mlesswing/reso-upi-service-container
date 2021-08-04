#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
# Start the container 
#
# Exit on first error, print all commands.
set -e

IMAGE_NAME="reso-upi-service-container"

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' Start a container' 
echo '============'
echo '' 
echo ' Image name: '$IMAGE_NAME
echo '' 

RESPONSE=`docker start $IMAGE_NAME` 

