package main

import (
	"context"
	"crypto/tls"
	"fmt"
	"io"
	"net"
	"net/http"
	"time"
)

func main() {
	var zeroDialer net.Dialer
	client := &http.Client{
		Transport: &http.Transport{
			MaxIdleConns:    -1,
			TLSNextProto:    map[string]func(string, *tls.Conn) http.RoundTripper{},
			TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
			DialContext: func(ctx context.Context, network, addr string) (net.Conn, error) {
				return zeroDialer.DialContext(ctx, "tcp4", addr)
			},
		},
	}
	for {
		for i := 1; i < 5; i++ {
			req, err := http.NewRequest("GET", "https://randomuser.me/api/", nil)
			if err != nil {
				panic(err)
			}
			req.Header.Set("cache-control", "no-cache")
			req.Header.Set("x-powered-by", "golang")
			res, err := client.Do(req)
			if err != nil {
				panic(err)
			}
			fmt.Printf("res: %+v\n", res)
			body, err := io.ReadAll(res.Body)
			if err != nil {
				panic(err)
			}
			fmt.Printf("body: %v\n", string(body))
		}

		time.Sleep(3 * time.Second)
	}
}
