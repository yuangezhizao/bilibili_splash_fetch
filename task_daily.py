import datetime
import hashlib
import json
import sys
import time

import requests


def calc_sign(param):
    sign_hash = hashlib.md5()
    sign_hash.update(f"{param}560c52ccd288fed045859ed18bffd973".encode('utf-8'))
    return sign_hash.hexdigest()


def bilibili_splash_fetch(access_key):
    url = 'https://app.bilibili.com/x/v2/splash/list'
    temp_params = f'access_key={access_key}&appkey=1d8b6e7d45233436&birth=0218&build=5370000&height=2560' \
                      f'&mobi_app=android&platform=android&ts=' + str(int((time.time() * 1000))) + '&width=1536'
    headers = {
        'User-Agent': 'Mozilla/5.0 BiliDroid/5.37.0 (bbcallen@gmail.com)'
    }
    sign = calc_sign(temp_params)
    params = temp_params + '&sign=' + sign
    r = requests.get(url, headers=headers, params=params).json()
    for i in range(len(r['data']['list'])):
        r['data']['list'][i]['request_id'] = '<rm>'
        r['data']['list'][i]['ad_cb'] = '<rm>'
        r['data']['show'] = '<rm>'
    json_file_name = datetime.datetime.now().strftime("%y%m%d-%H%M%S") + '.json'
    with open('./json_data/' + json_file_name, 'w', encoding='utf-8') as f:
        json.dump(r, f)


if __name__ == "__main__":
    bilibili_splash_fetch(sys.argv[1])
