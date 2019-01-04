#!/bin/bash
set -ev

folder="json_data"
if [ ! -d $folder ]; then
  mkdir $folder
fi

python task_daily.py ${access_key}

git config user.name "yuangezhizao"
git config user.email "root@yuangezhizao.cn"

git add .
git commit -m "Travis CI Cron Jobs at `date +"%Y-%m-%d %H:%M:%S"`"
git push --force "https://${TravisCIToken}@github.com/yuangezhizao/bilibili_splash_fetch.git" master:master
