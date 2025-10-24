#!/bin/bash

docker build . -t kubehq/mizutest-grpc-py-server:latest && docker push kubehq/mizutest-grpc-py-server:latest
