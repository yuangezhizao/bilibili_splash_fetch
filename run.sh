#!/bin/bash
set -ev

folder="json_data"
if [ ! -d $folder ]; then
  mkdir $folder
fi

python task_daily.py ${access_key}

cd ..
git clone "https://github.com/yuangezhizao/bilibili_splash_fetch_data.git" bilibili_splash_fetch_data

cd bilibili_splash_fetch_data
folder="raw"
if [ ! -d $folder ]; then
  mkdir $folder
fi
folder="rename"
if [ ! -d $folder ]; then
  mkdir $folder
fi
cd ..

cp -r bilibili_splash_fetch/json_data/. bilibili_splash_fetch_data/raw
cd bilibili_splash_fetch_data/raw
ls *.json |awk -F "-(.*?)" '{print "cp "$0" ../rename/"$1".json"}'|bash
cd ..

git config user.name "yuangezhizao"
git config user.email "root@yuangezhizao.cn"

git add .
git commit -m "Travis CI Cron Jobs at `date +"%Y-%m-%d %H:%M:%S"`"
git push "https://${TravisCIToken}@github.com/yuangezhizao/bilibili_splash_fetch_data.git"
