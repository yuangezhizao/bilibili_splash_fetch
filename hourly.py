#!/usr/bin/env/ python3
# -*- coding: utf-8 -*-
"""
    :Author: yuangezhizao
    :Time: 2019/2/4 0004 11:30
    :Site: https://www.yuangezhizao.cn
    :Copyright: © 2019 yuangezhizao <root@yuangezhizao.cn>
"""
import os
import zlib

hourly_path = '/root/bilibili_splash_fetch_data/hourly'
raw_path = '/root/bilibili_splash_fetch_data/raw'

hourly_files = os.listdir(hourly_path)
hourly_list = []
for hourly_file in hourly_files:
    hourly_list.append(hourly_file)

raw_files = os.listdir(raw_path)
for raw_file in raw_files:
    with open(os.path.join(raw_path, raw_file), encoding='utf-8') as f:
        read = f.read()
        crc32 = "%08x" % (zlib.crc32(read.encode()) % (1 << 32))
        if crc32 in str(hourly_list):
            continue
        with open(os.path.join(hourly_path, raw_file[:9] + '_' + crc32 + '.json'), 'w') as n:
            n.write(read)
