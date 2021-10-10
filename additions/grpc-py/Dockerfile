FROM python:3.8-slim-buster

WORKDIR /app
RUN apt-get update
RUN apt-get install -y git
RUN git clone -b v1.40.0 https://github.com/grpc/grpc
RUN pip3 install grpcio-tools

COPY run.sh .
