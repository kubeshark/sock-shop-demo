package main

import (
	"fmt"
	"io"
	"net/http"
	"strings"
)

const ACCESS_TOKEN = "c798b14b83d519ffc531ef816cfce81e7d53367dbd5c4d3171a06ad888fabdaf"

func main() {
	j := 0
	client := &http.Client{}

	payload := strings.NewReader(fmt.Sprintf("------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"email\"\r\n\r\njohn.doe.%d@example.com\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"name\"\r\n\r\nJohn\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"gender\"\r\n\r\nmale\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"status\"\r\n\r\nactive\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--", j))
	req, err := http.NewRequest("POST", "https://gorest.co.in/public/v2/users", payload)
	if err != nil {
		panic(err)
	}
	req.Header.Set("content-type", "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW")
	req.Header.Set("authorization", fmt.Sprintf("Bearer %s", ACCESS_TOKEN))
	req.Header.Set("cache-control", "no-cache")
	req.Header.Set("x-powered-by", "golang")
	res, err := client.Do(req)
	if err != nil {
		panic(err)
	}
	// fmt.Printf("res: %+v\n", res)

	req, err = http.NewRequest("GET", "https://gorest.co.in/public/v2/users", nil)
	if err != nil {
		panic(err)
	}
	req.Header.Set("cache-control", "no-cache")
	req.Header.Set("x-powered-by", "golang")
	res, err = client.Do(req)
	if err != nil {
		panic(err)
	}
	// fmt.Printf("res: %+v\n", res)

	req, err = http.NewRequest("GET", "https://gorest.co.in/public/v2/posts", nil)
	if err != nil {
		panic(err)
	}
	req.Header.Set("cache-control", "no-cache")
	req.Header.Set("x-powered-by", "golang")
	res, err = client.Do(req)
	if err != nil {
		panic(err)
	}
	// fmt.Printf("res: %+v\n", res)
	_, err = io.ReadAll(res.Body)
	if err != nil {
		panic(err)
	}
	// fmt.Printf("body: %v\n", string(body))
}
