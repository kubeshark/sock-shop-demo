#!/bin/bash

docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-server:latest && docker push mertyildiran/mizutest-inbound-tls-nodejs-server:latest

# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-server:10 --build-arg NODEVERSION=10 && docker push mertyildiran/mizutest-inbound-tls-nodejs-server:10 && \
# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-server:12 --build-arg NODEVERSION=12 && docker push mertyildiran/mizutest-inbound-tls-nodejs-server:12 && \
# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-server:14 --build-arg NODEVERSION=14 && docker push mertyildiran/mizutest-inbound-tls-nodejs-server:14 && \
# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-server:16 --build-arg NODEVERSION=16 && docker push mertyildiran/mizutest-inbound-tls-nodejs-server:16 && \
# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-server:18 --build-arg NODEVERSION=18 && docker push mertyildiran/mizutest-inbound-tls-nodejs-server:18
