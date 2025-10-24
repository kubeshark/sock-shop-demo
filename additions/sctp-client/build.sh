#!/bin/bash

docker build . -t kubehq/mizutest-sctp-client:latest && docker push kubehq/mizutest-sctp-client:latest
