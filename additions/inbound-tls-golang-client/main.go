package main

import (
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"
)

func main() {
	http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}
	client := &http.Client{}
	for {
		url := "https://mizutest-inbound-tls-golang-server:443/hello"

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
