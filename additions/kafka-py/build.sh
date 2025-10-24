#!/bin/bash

docker build . -t kubehq/mizutest-kafka-py:latest && docker push kubehq/mizutest-kafka-py:latest
