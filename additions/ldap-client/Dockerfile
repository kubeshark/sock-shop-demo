FROM golang:1.22 as builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY main.go .
RUN CGO_ENABLED=0 go build -o ldap-demo

FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/ldap-demo .
EXPOSE 8080
ENTRYPOINT ["./ldap-demo"]
