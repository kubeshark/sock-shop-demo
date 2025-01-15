#!/bin/bash

docker build . -t kubeshark/mizutest-diameter-client:latest && docker push kubeshark/mizutest-diameter-client:latest
