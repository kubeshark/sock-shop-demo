import time
import requests
import traceback
import logging

ACCESS_TOKEN = 'c798b14b83d519ffc531ef816cfce81e7d53367dbd5c4d3171a06ad888fabdaf'

j = 0
while True:
    j += 1
    # print("-----\n%d" % j)

    url = "https://gorest.co.in/public/v2/users"

    payload = "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"email\"\r\n\r\njohn.doe.%d@example.com\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"name\"\r\n\r\nJohn\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"gender\"\r\n\r\nmale\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"status\"\r\n\r\nactive\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--" % j
    headers = {
        'content-type': "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
        'authorization': "Bearer %s" % ACCESS_TOKEN,
        'cache-control': "no-cache",
        'user-agent': "outbound-tls-openssl",
    }

    try:
        response = requests.request("POST", url, data=payload, headers=headers)
    except Exception as e:
        logging.error(traceback.format_exc())

    # print(response.text)

    url = "https://gorest.co.in/public/v2/users"

    headers = {
        'cache-control': "no-cache",
        'user-agent': "outbound-tls-openssl",
    }

    try:
        response = requests.request("GET", url, headers=headers)
    except Exception as e:
        logging.error(traceback.format_exc())

    # print(response.text)

    url = "https://gorest.co.in/public/v2/posts"

    headers = {
        'cache-control': "no-cache",
        'user-agent': "outbound-tls-openssl",
    }

    try:
        response = requests.request("GET", url, headers=headers)
    except Exception as e:
        logging.error(traceback.format_exc())

    # print(response.text)
    time.sleep(3)
