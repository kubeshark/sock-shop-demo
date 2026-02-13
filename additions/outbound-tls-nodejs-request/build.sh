#!/bin/bash

docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-request:latest && docker push mertyildiran/mizutest-outbound-tls-nodejs-request:latest

# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-request:10 --build-arg NODEVERSION=10 && docker push mertyildiran/mizutest-outbound-tls-nodejs-request:10 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-request:12 --build-arg NODEVERSION=12 && docker push mertyildiran/mizutest-outbound-tls-nodejs-request:12 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-request:14 --build-arg NODEVERSION=14 && docker push mertyildiran/mizutest-outbound-tls-nodejs-request:14 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-request:16 --build-arg NODEVERSION=16 && docker push mertyildiran/mizutest-outbound-tls-nodejs-request:16 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-request:18 --build-arg NODEVERSION=18 && docker push mertyildiran/mizutest-outbound-tls-nodejs-request:18
