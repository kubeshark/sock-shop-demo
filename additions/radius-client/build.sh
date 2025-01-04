#!/bin/bash

docker build . -t kubeshark/mizutest-radius-client:latest && docker push kubeshark/mizutest-radius-client:latest
