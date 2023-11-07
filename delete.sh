#!/bin/bash

# Stop all running containers
docker stop $(docker ps -a -q)

# Remove all stopped containers
docker rm $(docker ps -a -q)

# Remove volume dev_connect_data
docker volume remove dev_connect_data
# docker volume prune 


# Remove all images
docker rmi -f $(docker images -a -q)