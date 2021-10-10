FROM golang:1.16-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download
RUN apk update && apk add bash nano

COPY *.go ./
RUN go build -o main main.go
COPY run.sh .
