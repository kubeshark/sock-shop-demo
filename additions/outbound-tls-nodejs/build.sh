#!/bin/bash

docker build . -t mertyildiran/mizutest-outbound-tls-nodejs:latest && docker push mertyildiran/mizutest-outbound-tls-nodejs:latest

# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs:10 --build-arg NODEVERSION=10 && docker push mertyildiran/mizutest-outbound-tls-nodejs:10 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs:12 --build-arg NODEVERSION=12 && docker push mertyildiran/mizutest-outbound-tls-nodejs:12 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs:14 --build-arg NODEVERSION=14 && docker push mertyildiran/mizutest-outbound-tls-nodejs:14 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs:16 --build-arg NODEVERSION=16 && docker push mertyildiran/mizutest-outbound-tls-nodejs:16 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs:18 --build-arg NODEVERSION=18 && docker push mertyildiran/mizutest-outbound-tls-nodejs:18
