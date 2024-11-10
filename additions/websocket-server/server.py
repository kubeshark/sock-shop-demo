import asyncio
import websockets
import argparse

# WebSocket server handler
async def echo(websocket, path):
    print(f"New connection from: {websocket.remote_address}, Compression: {websocket.extensions}")

    try:
        async for message in websocket:
            print(f"Received message: {message}")
            await websocket.send(f"Echo: {message}")
    except websockets.exceptions.ConnectionClosed as e:
        print(f"Connection closed: {e}")

# Main function to start the server
async def main():
    # Set up CLI argument parsing
    parser = argparse.ArgumentParser(description="WebSocket Server with optional client-requested compression")
    parser.add_argument('--port', type=int, default=8765, help="Port number to listen on")

    args = parser.parse_args()

    # Define the server with compression support (client-requested)
    server = await websockets.serve(
        echo,
        "0.0.0.0",  # Address to bind the server
        args.port,    # Port number from CLI
        compression="deflate"  # Enable permessage-deflate compression if the client requests it
    )

    print(f"WebSocket server started on ws://localhost:{args.port}")
    print("Compression will be enabled if the client requests it.")

    # Run the server until it's manually stopped
    await server.wait_closed()

# Run the server
if __name__ == "__main__":
    asyncio.run(main())
