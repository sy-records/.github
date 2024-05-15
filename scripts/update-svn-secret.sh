#!/bin/bash

repos=("qiniu-kodo-wordpress" "aliyun-oss-wordpress" "wordpress-qcloud-cos" "realtimehot-weibo" "wp-baidu-textcensor" "textcensor-for-articles" "random-look" "MemorialDay" "upyun-uss-wordpress" "volcengine-imagex-wordpress" "huaweicloud-obs-wordpress" "pinyin-slug" "pangu.js" "sy-mailer")
owner="sy-records"

echo "Please enter your SVN_USERNAME:"
read SVN_USERNAME
echo "SVN_USERNAME is ${SVN_USERNAME}"

echo "Please enter your SVN_PASSWORD:"
read SVN_PASSWORD
echo "SVN_PASSWORD is ${SVN_PASSWORD}"

echo "Sure to update secrets? (y/n)"
read confirm
if [ "$confirm" != "y" ]; then
  echo "Aborted."
  exit 1
fi

for repository in "${repos[@]}"
do
  if [ -n "$SVN_USERNAME" ]; then
    gh secret set SVN_USERNAME --body "$SVN_USERNAME" --repo "${owner}/${repository}"
  fi
  if [ -n "$SVN_PASSWORD" ]; then
    gh secret set SVN_PASSWORD --body "$SVN_PASSWORD" --repo "${owner}/${repository}"
  fi
done
