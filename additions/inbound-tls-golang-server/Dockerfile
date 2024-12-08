FROM golang:1.17-alpine

WORKDIR /app

COPY server.crt .
COPY server.key .
COPY main.go .
RUN go build -o main main.go
