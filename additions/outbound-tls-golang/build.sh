#!/bin/bash

# docker build . -t mertyildiran/mizutest-outbound-tls-golang:latest && docker push mertyildiran/mizutest-outbound-tls-golang:latest
docker buildx build --platform linux/amd64,linux/arm64 -t kubeshark/mizutest-outbound-tls-golang:latest . --push
