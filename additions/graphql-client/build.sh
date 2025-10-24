#!/bin/bash

docker build . -t kubehq/mizutest-graphql-client:latest && docker push kubehq/mizutest-graphql-client:latest
