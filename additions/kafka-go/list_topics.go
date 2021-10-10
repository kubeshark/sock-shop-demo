package main

import (
	"fmt"

	"github.com/segmentio/kafka-go"
)

func main() {
	fmt.Println("List Topics")
	conn, err := kafka.Dial("tcp", "kafka:9092")
	if err != nil {
		panic(err.Error())
	}
	defer conn.Close()

	partitions, err := conn.ReadPartitions()
	if err != nil {
		panic(err.Error())
	}

	m := map[string]struct{}{}

	for _, p := range partitions {
		m[p.Topic] = struct{}{}
	}
	for k := range m {
		fmt.Println(k)
	}
}
