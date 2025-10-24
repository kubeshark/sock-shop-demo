#!/bin/bash

docker build . -t kubehq/mizutest-kafka-go:latest && docker push kubehq/mizutest-kafka-go:latest
