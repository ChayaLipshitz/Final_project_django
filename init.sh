#!/bin/bash

docker build --tag dev_connect .

# create a volume: dev_connect_data
docker volume create dev_connect_data

docker run -p 8000:8000 --name dev_connect -v dev_connect_data:/usr/src/app dev_connect

# docker run -p 8000:8000 --cpus "2.0" --memory "1g" dev_connect

# kubectl create deployment dev_connect --image=us-west1-docker.pkg.dev/devconnect-project/chaya-lipshitz-artifacts/dev_connect:1.0.0 -n=production 

# gcloud auth configure-docker

# docker pull us-west1-docker.pkg.dev/devconnect-project/chaya-lipshitz-artifacts/dev_connect:1.0.0