package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"strconv"
	"time"

	"github.com/segmentio/kafka-go"
)

func main() {
	fmt.Println("Produce")
	// to produce messages
	topic := "invoicing"
	partition := 0

	conn, err := kafka.DialLeader(context.Background(), "tcp", "kafka:9092", topic, partition)
	if err != nil {
		log.Fatal("failed to dial leader:", err)
	}

	controller, err := conn.Controller()
	if err != nil {
		panic(err.Error())
	}
	var controllerConn *kafka.Conn
	controllerConn, err = kafka.Dial("tcp", net.JoinHostPort(controller.Host, strconv.Itoa(controller.Port)))
	if err != nil {
		panic(err.Error())
	}
	defer controllerConn.Close()

	topicConfigs := []kafka.TopicConfig{
		kafka.TopicConfig{
			Topic:             topic,
			NumPartitions:     1,
			ReplicationFactor: 1,
		},
	}

	err = controllerConn.CreateTopics(topicConfigs...)

	conn.SetWriteDeadline(time.Now().Add(10 * time.Second))
	_, err = conn.WriteMessages(
		kafka.Message{Key: []byte("key-one"), Value: []byte("one!"), Headers: []kafka.Header{{Key: "hdr1", Value: []byte("val1")}}},
		kafka.Message{Key: []byte("key-two"), Value: []byte("two!"), Headers: []kafka.Header{{Key: "hdr2", Value: []byte("val2")}}},
		kafka.Message{Key: []byte("key-three"), Value: []byte("three!"), Headers: []kafka.Header{{Key: "hdr3", Value: []byte("val3")}}},
	)
	if err != nil {
		log.Fatal("failed to write messages:", err)
	}

	if err := conn.Close(); err != nil {
		log.Fatal("failed to close writer:", err)
	}
}
