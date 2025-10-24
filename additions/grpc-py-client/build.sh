#!/bin/bash

docker build . -t kubehq/mizutest-grpc-py-client:latest && docker push kubehq/mizutest-grpc-py-client:latest
