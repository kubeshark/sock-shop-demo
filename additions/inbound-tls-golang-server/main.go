package main

import (
	"net"
	"net/http"
)

func HelloServer(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "text/plain")
	w.Write([]byte("This is an example server.\n"))
}

func main() {
	http.HandleFunc("/hello", HelloServer)
	err := http.ListenAndServeTLS(":8083", "server.crt", "server.key", nil)
	srv := &http.Server{Addr: ":8083", Handler: nil}
	addr := srv.Addr
	if addr == "" {
		addr = ":https"
	}

	ln, err := net.Listen("tcp4", addr)
	if err != nil {
		panic(err)
	}

	defer ln.Close()

	err = srv.ServeTLS(ln, "server.crt", "server.key")
	if err != nil {
		panic(err)
	}
}
