import websocket
import time

def connect():
    try:
        ws = websocket.WebSocket()
        ws.connect("ws://echo.websocket.events")
        return ws
    except Exception as e:
        print(f"Error connecting to WebSocket: {e}")
        return None

def run():
    ws = connect()
    message_count = 1  # Start the message counter at 1
    while ws:
        try:
            message = f"Hello, Server (Message {message_count})"
            ws.send(message)
            print(f"Sent: {message}")
            response = ws.recv()
            print(f"Received: {response}")
            message_count += 1  # Increment the message counter
            time.sleep(3)
        except Exception as e:
            print(f"Error during communication: {e}")
            ws.close()
            print("Attempting to reconnect...")
            ws = connect()

if __name__ == "__main__":
    run()
