package main

import (
	"context"
	"crypto/tls"
	"fmt"
	"io"
	"net"
	"net/http"
	"strings"
	"time"
)

const ACCESS_TOKEN = "0558fc2e748cc7427ab6f4b16e5ca0c469eccd32cc5c7d1d1a83614f94e5f186"

func main() {
	j := 0
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
		j++

		// Include the index 'j' in the query parameter of the URL
		getURL := fmt.Sprintf("https://gorest.co.in/public/v2/not-found?index=%d", j)
		req, err := http.NewRequest("GET", getURL, nil)
		if err != nil {
			fmt.Println(err)
			continue
		}
		req.Header.Set("cache-control", "no-cache")
		req.Header.Set("x-powered-by", "golang")
		res, err := client.Do(req)
		if err != nil {
			fmt.Println(err)
			continue
		}
		_, err = io.ReadAll(res.Body)
		if err != nil {
			fmt.Println(err)
			continue
		}
		fmt.Printf("res: %+v\n", res)
		res.Body.Close()

		payload := strings.NewReader(fmt.Sprintf("------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"email\"\r\n\r\njohn.doe.%d@example.com\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"name\"\r\n\r\nJohn\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"gender\"\r\n\r\nmale\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"status\"\r\n\r\nactive\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--", j))
		req, err = http.NewRequest("POST", "https://gorest.co.in/public/v2/users", payload)
		if err != nil {
			fmt.Println(err)
			continue
		}
		req.Header.Set("content-type", "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW")
		req.Header.Set("authorization", fmt.Sprintf("Bearer %s", ACCESS_TOKEN))
		req.Header.Set("cache-control", "no-cache")
		req.Header.Set("x-powered-by", "golang")
		res, err = client.Do(req)
		if err != nil {
			fmt.Println(err)
			continue
		}
		_, err = io.ReadAll(res.Body)
		if err != nil {
			fmt.Println(err)
			continue
		}
		fmt.Printf("res: %+v\n", res)
		res.Body.Close()

		// Include the index 'j' in the query parameter of the GET request for users
		getUsersURL := fmt.Sprintf("https://gorest.co.in/public/v2/users?index=%d", j)
		req, err = http.NewRequest("GET", getUsersURL, nil)
		if err != nil {
			fmt.Println(err)
			continue
		}
		req.Header.Set("cache-control", "no-cache")
		req.Header.Set("x-powered-by", "golang")
		res, err = client.Do(req)
		if err != nil {
			fmt.Println(err)
			continue
		}
		_, err = io.ReadAll(res.Body)
		if err != nil {
			fmt.Println(err)
			continue
		}
		fmt.Printf("res: %+v\n", res)
		res.Body.Close()

		// Include the index 'j' in the query parameter of the GET request for posts
		getPostsURL := fmt.Sprintf("https://gorest.co.in/public/v2/posts?index=%d", j)
		req, err = http.NewRequest("GET", getPostsURL, nil)
		if err != nil {
			fmt.Println(err)
			continue
		}
		req.Header.Set("cache-control", "no-cache")
		req.Header.Set("x-powered-by", "golang")
		res, err = client.Do(req)
		if err != nil {
			fmt.Println(err)
			continue
		}
		_, err = io.ReadAll(res.Body)
		if err != nil {
			fmt.Println(err)
		}
		fmt.Printf("res: %+v\n", res)
		res.Body.Close()

		time.Sleep(3 * time.Second)
	}
}
