#!/bin/bash

# Get the version from the user

if [ -z "$1" ]; then
  read -p "Enter version: " version
else
  version=$1
fi

echo "version is: {$version}"
IMAGE_EXISTS=$(docker image inspect  dev_connect:$version | wc -l)
UN_BUILD=0

# If the image exists, ask the user if they want to rebuild it
if [ "$IMAGE_EXISTS" -eq 106 ]; then
  echo "Image  dev_connect:$version already exists."
  read -p "Do you want to rebuild it? (Y/N) " REBUILD

  # If the user chooses to rebuild the image, delete the existing one
  if [ "$REBUILD" = "Y" ]; then
    echo "Deleting existing image..."
    docker rmi dev_connect:$version
  else
    UN_BUILD=1
  fi
fi

# Build the image
if [ "$UN_BUILD" -eq 0 ]; then
  docker build -t dev_connect:$version .
fi

# Tag the app and the image
read -p "Do you want to tagging and pushing this deploying? (Y/N) " TAGGING
if [ "$TAGGING" = "Y" ]; then
    gcloud auth configure-docker us-west1-docker.pkg.dev 
    # tagging th image for push to artifact registry in google
    docker tag dev_connect:$version us-west1-docker.pkg.dev/devconnect-project/chaya-lipshitz-artifacts/dev_connect:$version
    docker push us-west1-docker.pkg.dev/devconnect-project/chaya-lipshitz-artifacts/dev_connect:$version
fi

# If something was feild
if [ "$?" -ne 0 ]; then
  echo "There was an error deploying the image."
  exit 1
fi


	# kubectl get services
