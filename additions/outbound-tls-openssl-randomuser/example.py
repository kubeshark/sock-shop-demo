import time
import requests
import traceback
import logging
import itertools

while True:
    for _ in itertools.repeat(None, 3):
        url = "https://randomuser.me/api/"

        headers = {
            'cache-control': "no-cache",
            'x-powered-by': "openssl",
        }

        try:
            response = requests.request("GET", url, headers=headers)
        except Exception as e:
            logging.error(traceback.format_exc())

        print(response.text)
    time.sleep(3)
