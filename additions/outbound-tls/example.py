import time
import requests

ACCESS_TOKEN = '4c702fb4a535d46c25a4071ae95178bdd677db164ec73d90a5e4d4f17b02b0c2'

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
    }

    response = requests.request("POST", url, data=payload, headers=headers)

    # print(response.text)

    url = "https://gorest.co.in/public/v2/users"

    headers = {
        'cache-control': "no-cache",
    }

    response = requests.request("GET", url, headers=headers)

    # print(response.text)

    url = "https://gorest.co.in/public/v2/posts"

    headers = {
        'cache-control': "no-cache",
    }

    response = requests.request("GET", url, headers=headers)

    # print(response.text)
    
    time.sleep(3)
