import socket
import sctp
import time

print("Start SCTP client")

sock = sctp.sctpsocket_tcp(socket.AF_INET)

cnt = 0
connected = False
while True:
  if not connected:
    try:
      sock.connect(("mizutest-sctp-server", 50051))
    except:
      print("couldn't connect")
      time.sleep(3)
      continue

  connected = True

  msg = 'hello world %s' % cnt
  sock.sctp_send(msg=msg)
  print("Sent %s" % msg)
  cnt += 1

  time.sleep(3)

sock.shutdown(0)


sock.close()
