import time
import requests
import traceback
import logging

ACCESS_TOKEN = '0558fc2e748cc7427ab6f4b16e5ca0c469eccd32cc5c7d1d1a83614f94e5f186'

j = 0
while True:
    j += 1
    # print("-----\n%d" % j)

    # First request - POST
    url = "https://gorest.co.in/public/v2/users"
    payload = "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"email\"\r\n\r\njohn.doe.%d@example.com\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"name\"\r\n\r\nJohn\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"gender\"\r\n\r\nmale\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"status\"\r\n\r\nactive\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--" % j
    headers = {
        'content-type': "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
        'authorization': "Bearer %s" % ACCESS_TOKEN,
        'cache-control': "no-cache",
        'x-powered-by': "openssl",
    }

    try:
        response = requests.request("POST", url, data=payload, headers=headers)
        print(response.text)
        response.close()
    except Exception as e:
        logging.error(traceback.format_exc())

    # Second request - GET
    url = "https://gorest.co.in/public/v2/users"
    headers = {
        'cache-control': "no-cache",
        'x-powered-by': "openssl",
    }

    try:
        response = requests.request("GET", url, headers=headers)
        print(response.text)
        response.close()
    except Exception as e:
        logging.error(traceback.format_exc())

    # Third request - GET
    url = "https://gorest.co.in/public/v2/posts"
    headers = {
        'cache-control': "no-cache",
        'x-powered-by': "openssl",
    }

    try:
        response = requests.request("GET", url, headers=headers)
        print(response.text)
        response.close()
    except Exception as e:
        logging.error(traceback.format_exc())

    # Wait for 3 seconds before the next iteration
    time.sleep(3)
