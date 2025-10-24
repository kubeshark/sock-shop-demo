#!/bin/bash

docker build . -t kubehq/mizutest-sctp-server:latest && docker push kubehq/mizutest-sctp-server:latest
