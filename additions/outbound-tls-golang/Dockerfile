FROM golang:1.17-alpine

WORKDIR /app

RUN apk update && apk add bash nano

COPY main.go ./
RUN go build -o main main.go
