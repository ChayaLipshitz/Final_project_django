#!/bin/bash

docker build --tag dev_connect .

# docker volume create dev_connect_data

docker run -p 8000:8000 -v chat-app-data:/usr/src/app dev_connect

# docker run -p 8000:8000 --cpus "2.0" --memory "1g" dev_connect