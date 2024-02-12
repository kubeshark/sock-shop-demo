#!/bin/bash

docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-axios:latest && docker push mertyildiran/mizutest-outbound-tls-nodejs-axios:latest

# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-axios:10 --build-arg NODEVERSION=10 && docker push mertyildiran/mizutest-outbound-tls-nodejs-axios:10 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-axios:12 --build-arg NODEVERSION=12 && docker push mertyildiran/mizutest-outbound-tls-nodejs-axios:12 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-axios:14 --build-arg NODEVERSION=14 && docker push mertyildiran/mizutest-outbound-tls-nodejs-axios:14 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-axios:16 --build-arg NODEVERSION=16 && docker push mertyildiran/mizutest-outbound-tls-nodejs-axios:16 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-axios:18 --build-arg NODEVERSION=18 && docker push mertyildiran/mizutest-outbound-tls-nodejs-axios:18
