#!/bin/bash

docker build . -t kubeshark/mizutest-diameter-server:latest && docker push kubeshark/mizutest-diameter-server:latest
