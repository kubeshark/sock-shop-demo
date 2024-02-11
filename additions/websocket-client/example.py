import websocket
import time

while True:
  ws = websocket.WebSocket()
  ws.connect("ws://echo.websocket.events")
  ws.send("Hello, Server")

  print(ws.recv())

  ws.close()

  time.sleep(3)
