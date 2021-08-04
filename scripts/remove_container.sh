#!/bin/bash
#
# Copyright 2019-2021 Lesswing LLC
#
# Remove the container 
#
# Exit on first error, print all commands.
set -e

IMAGE_NAME="reso-upi-service-container"

echo '============'
echo ' RESO UPI Service'
echo '' 
echo ' Remove a container' 
echo '============'
echo '' 
echo ' Image name: '$IMAGE_NAME
echo '' 

RESPONSE=`docker stop $IMAGE_NAME` 

# Prune docker 
docker system prune --all ; docker volume prune ; docker ps --all ; docker images --all ; docker volume ls

# Your system is now clean
echo '' 

