package main

import (
	"context"
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"net"
	"net/http"
	"time"
)

func main() {
	var zeroDialer net.Dialer
	client := &http.Client{
		Transport: &http.Transport{
			TLSNextProto:    map[string]func(string, *tls.Conn) http.RoundTripper{},
			TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
			DialContext: func(ctx context.Context, network, addr string) (net.Conn, error) {
				return zeroDialer.DialContext(ctx, "tcp4", addr)
			},
		},
	}
	for {
		url := "https://mizutest-inbound-tls-golang-server:8083/hello"

		req, err := http.NewRequest("GET", url, nil)
		if err != nil {
			panic(err)
		}

		req.Header.Add("cache-control", "no-cache")
		req.Header.Add("x-powered-by", "golang")

		res, err := client.Do(req)
		if err != nil {
			panic(err)
		}

		defer res.Body.Close()
		body, err := ioutil.ReadAll(res.Body)
		if err != nil {
			panic(err)
		}

		fmt.Println(res)
		fmt.Println(string(body))

		time.Sleep(3 * time.Second)
	}
}
