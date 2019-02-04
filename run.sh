#!/bin/bash
source /etc/profile

set -ev
export TZ='Asia/Shanghai'

folder="json_data"
if [[ -d ${folder} ]]; then
  rm -rf ${folder}
fi
if [[ ! -d ${folder} ]]; then
  mkdir ${folder}
fi

python task_daily.py ${access_key}

cd ..
folder="bilibili_splash_fetch_data"
if [[  -d ${folder} ]]; then
  rm -rf ${folder}
fi
git clone "https://github.com/yuangezhizao/bilibili_splash_fetch_data.git" bilibili_splash_fetch_data

cd bilibili_splash_fetch_data
folder="raw"
if [[ ! -d ${folder} ]]; then
  mkdir ${folder}
fi
folder="hourly"
if [[ ! -d ${folder} ]]; then
  mkdir ${folder}
fi
cd ..

cp -r bilibili_splash_fetch/json_data/. bilibili_splash_fetch_data/raw
cd bilibili_splash_fetch
python hourly.py
cd ../bilibili_splash_fetch_data

git config user.name "yuangezhizao"
git config user.email "root@yuangezhizao.cn"

git add .
git commit -m "CentOS Server Cron Jobs at `date +"%Y-%m-%d %H:%M:%S"`"
git push "https://${TravisCIToken}@github.com/yuangezhizao/bilibili_splash_fetch_data.git"
