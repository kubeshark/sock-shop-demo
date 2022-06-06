#!/bin/bash

docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-fetch:latest && docker push mertyildiran/mizutest-outbound-tls-nodejs-fetch:latest

# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-fetch:10 --build-arg NODEVERSION=10 && docker push mertyildiran/mizutest-outbound-tls-nodejs-fetch:10 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-fetch:12 --build-arg NODEVERSION=12 && docker push mertyildiran/mizutest-outbound-tls-nodejs-fetch:12 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-fetch:14 --build-arg NODEVERSION=14 && docker push mertyildiran/mizutest-outbound-tls-nodejs-fetch:14 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-fetch:16 --build-arg NODEVERSION=16 && docker push mertyildiran/mizutest-outbound-tls-nodejs-fetch:16 && \
# docker build . -t mertyildiran/mizutest-outbound-tls-nodejs-fetch:18 --build-arg NODEVERSION=18 && docker push mertyildiran/mizutest-outbound-tls-nodejs-fetch:18
