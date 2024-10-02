#!/bin/bash

# docker build . -t kubeshark/mizutest-websocket-client:latest && docker push kubeshark/mizutest-websocket-client:latest
docker buildx build --platform linux/amd64,linux/arm64 -t kubeshark/mizutest-websocket-client:latest . --push

