#!/bin/bash

# Define variables
IMAGE_NAME="kubeshark/mizutest-websocket-server"
VERSION=${1:-latest}  # Use the provided version or default to 'latest'
PORT=${2:-80}        # Use provided port or default to 8765

# Ensure Docker Buildx is available and use it
echo "Ensuring Docker Buildx is set up..."
docker buildx create --use || docker buildx use default

# Build the multi-platform image (AMD64 and ARM64) and push it to the registry
echo "Building and pushing Docker image for AMD64 and ARM64 architectures..."
docker buildx build --platform linux/amd64,linux/arm64 -t $IMAGE_NAME:$VERSION . --push

echo "Docker image $IMAGE_NAME:$VERSION built and pushed successfully!"

# Run the container (optional step)
# Uncomment to run the container with the specified port
# echo "Running Docker container on port $PORT..."
# docker run -d -p $PORT:$PORT -e PORT=$PORT $IMAGE_NAME:$VERSION
