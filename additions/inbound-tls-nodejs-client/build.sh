#!/bin/bash

docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-client:latest && docker push mertyildiran/mizutest-inbound-tls-nodejs-client:latest

# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-client:10 --build-arg NODEVERSION=10 && docker push mertyildiran/mizutest-inbound-tls-nodejs-client:10 && \
# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-client:12 --build-arg NODEVERSION=12 && docker push mertyildiran/mizutest-inbound-tls-nodejs-client:12 && \
# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-client:14 --build-arg NODEVERSION=14 && docker push mertyildiran/mizutest-inbound-tls-nodejs-client:14 && \
# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-client:16 --build-arg NODEVERSION=16 && docker push mertyildiran/mizutest-inbound-tls-nodejs-client:16 && \
# docker build . -t mertyildiran/mizutest-inbound-tls-nodejs-client:18 --build-arg NODEVERSION=18 && docker push mertyildiran/mizutest-inbound-tls-nodejs-client:18
