#!/bin/bash
#
# Copyright 2019-2020 Lesswing LLC
#
# Stop the container 
#
# Exit on first error, print all commands.
set -e

IMAGE_NAME="reso-upi-service-container"

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' Stop a container' 
echo '============'
echo '' 
echo ' Image name: '$IMAGE_NAME
echo '' 

RESPONSE=`docker stop $IMAGE_NAME` 

