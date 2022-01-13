FROM golang:1.16-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download
RUN apk update && apk add bash nano

COPY *.go ./
RUN go build -o consume consume.go
RUN go build -o create_topics create_topics.go
RUN go build -o list_topics list_topics.go
RUN go build -o produce produce.go
COPY run.sh .
