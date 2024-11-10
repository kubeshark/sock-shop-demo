import websocket
import time
import argparse

# Function to connect to the WebSocket server
def connect(server_url, use_compression):
    while True:
        try:
            headers = []
            
            # Include the compression extension if requested
            if use_compression:
                headers.append("Sec-WebSocket-Extensions: permessage-deflate")

            ws = websocket.WebSocket()
            ws.connect(server_url, header=headers)  # Use the server URL passed as an argument

            print(f"Connected to WebSocket server {server_url} (Compression: {use_compression})")
            return ws
        except Exception as e:
            print(f"Error connecting to WebSocket: {e}. Retrying in 30 seconds...")
            time.sleep(30)  # Wait 30 seconds before retrying

            
# Function to send and receive messages
def run(server_url, use_compression):
    ws = connect(server_url, use_compression=use_compression)
    message_count = 1  # Start the message counter at 1
    while True:
        try:
            message = f"Hello, Server (Message {message_count})"
            ws.send(message)
            print(f"Sent: {message}")
            response = ws.recv()
            print(f"Received: {response}")
            message_count += 1  # Increment the message counter
            time.sleep(3)  # Wait 3 seconds between messages
        except Exception as e:
            print(f"Error during communication: {e}. Reconnecting...")
            ws.close()
            ws = connect(server_url, use_compression=use_compression)

if __name__ == "__main__":
    # Set up argparse
    parser = argparse.ArgumentParser(description="WebSocket client with optional compression")
    parser.add_argument(
        "--server", 
        type=str, 
        required=True, 
        help="WebSocket server URL (e.g., ws://websocket-server-service.sock-shop.svc.cluster.local:80)"
    )
    parser.add_argument(
        "--compressed", 
        type=str, 
        choices=["true", "false"], 
        default="false", 
        help="Enable WebSocket compression"
    )
    
    args = parser.parse_args()
    server_url = args.server  # Get the server URL from the argument
    use_compression = args.compressed.lower() == "true"
    
    run(server_url, use_compression)
