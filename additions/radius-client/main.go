package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"time"

	"layeh.com/radius"
	"layeh.com/radius/rfc2865"
)

func main() {
	server := flag.String("server", "127.0.0.1", "RADIUS server address")
	port := flag.Int("port", 1812, "RADIUS server port")
	flag.Parse()

	for range time.Tick(3 * time.Second) {
		packet := radius.New(radius.CodeAccessRequest, []byte(`secret`))
		rfc2865.UserName_SetString(packet, "kubeshark")
		rfc2865.UserPassword_SetString(packet, "12345")
		response, err := radius.Exchange(
			context.Background(),
			packet,
			fmt.Sprintf("%s:%d", *server, *port),
		)
		if err != nil {
			log.Fatal(err)
		}

		log.Println("Code:", response.Code)
	}
}
