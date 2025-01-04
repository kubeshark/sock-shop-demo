#!/bin/bash

docker build . -t kubeshark/mizutest-radius-server:latest && docker push kubeshark/mizutest-radius-server:latest
