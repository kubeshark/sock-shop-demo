#!/bin/bash

# docker build . -t mertyildiran/mizutest-outbound-tls-golang:latest && docker push mertyildiran/mizutest-outbound-tls-golang:latest
docker buildx build --platform linux/amd64 -t alongir/mizutest-outbound-tls-openssl:latest . --push 