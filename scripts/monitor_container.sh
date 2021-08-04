#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
#  Monitor the container 
#
# Exit on first error, print all commands.
set -e

IMAGE_NAME="reso-upi-service-container"

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' Monitor a container' 
echo '============'
echo '' 
echo ' Image name: '$IMAGE_NAME

docker logs --follow $IMAGE_NAME 
