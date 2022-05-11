import time
import os
from faker import Faker

from pika import BlockingConnection, ConnectionParameters
from pika.spec import BasicProperties
from pika.exceptions import ChannelClosedByBroker, StreamLostError, AMQPConnectionError


fake = Faker()

EXCHANGE = 'topic_logs'
EXCHANGE_TYPE = 'topic'
# HOST = '192.168.49.2'
# PORT = '31583'
# HOST = 'localhost'
HOST = 'rabbitmq'
PORT = '5672'

amqp_properties = {
    'content_type': 'text/plain',
    'content_encoding': 'utf-8'
}

def _decoder(value):
    try:
        return value.decode()
    except (AttributeError, UnicodeDecodeError):
        return value

def callback(ch, method, properties: BasicProperties, body: bytes):
    print(
        None if not method.routing_key else method.routing_key,
        _decoder(body),
        properties.headers,
        {x: getattr(properties, x) for x in properties.__dict__ if x != 'headers'}
    )

j = 0
while True:
    j += 1
    print("-----\n%d" % j)
    connection = BlockingConnection(
        ConnectionParameters(host=HOST, port=PORT)
    )
    channel = connection.channel()

    queue = 'shipping'

    channel.queue_declare(queue=queue)
    print("Declared queue")

    exchange = '%s_%s' % (EXCHANGE, queue)

    channel.exchange_declare(exchange=exchange, exchange_type=EXCHANGE_TYPE)
    print("Declared exchange")

    channel.queue_bind(
        exchange=exchange,
        queue=queue,
        routing_key='#'
    )

    print("Queue bind")

    channel.basic_consume(queue=queue, on_message_callback=callback, auto_ack=True)

    print("Basic consume")

    # for i in range(20):
    for i in range(2):
        # os.system("curl -X GET http://neverssl.com\?%s\=%s\&%s\=%s -v" % (fake.word(), fake.word(), fake.word(), fake.word()))
        channel.basic_publish(
            exchange=exchange,
            routing_key='key%d' % i,
            body='value%d' % i,
            properties=BasicProperties(
                headers={
                    'hdr%d' % i: 'hdr_val%d' % i
                },
                **amqp_properties
            )
        )

        print("Basic publish")
        # os.system("curl -X GET http://neverssl.com\?%s\=%s\&%s\=%s -v" % (fake.word(), fake.word(), fake.word(), fake.word()))

    time.sleep(5)

    connection.close()
