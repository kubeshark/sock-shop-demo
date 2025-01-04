package main

import (
	"flag"
	"fmt"
	"log"

	"layeh.com/radius"
	"layeh.com/radius/rfc2865"
)

func main() {
	port := flag.Int("port", 1812, "RADIUS server port")
	network := flag.String("network", "udp", "udp or tcp")
	flag.Parse()

	handler := func(w radius.ResponseWriter, r *radius.Request) {
		username := rfc2865.UserName_GetString(r.Packet)
		password := rfc2865.UserPassword_GetString(r.Packet)

		var code radius.Code
		if username == "kubeshark" && password == "12345" {
			code = radius.CodeAccessAccept
		} else {
			code = radius.CodeAccessReject
		}
		log.Printf("Writing %v to %v", code, r.RemoteAddr)
		w.Write(r.Response(code))
	}

	server := radius.PacketServer{
		Addr:         fmt.Sprintf(":%d", *port),
		Network:      *network,
		Handler:      radius.HandlerFunc(handler),
		SecretSource: radius.StaticSecretSource([]byte(`secret`)),
	}

	log.Printf("Starting server on :%d", *port)
	if err := server.ListenAndServe(); err != nil {
		log.Fatal(err)
	}
}
