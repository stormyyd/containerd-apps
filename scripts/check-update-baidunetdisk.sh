#!/usr/bin/env bash

set -e

metadata=$(curl -s \
  -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36" \
  -e "https://pan.baidu.com" \
  "https://pan.baidu.com/disk/cmsdata?do=client")
version=$(echo ${metadata} | jq -r ".linux.version" | grep -oP "\d+.\d+.\d+")
url=$(echo ${metadata} | jq -r ".linux.url_1")
echo "BaiduNetdisk latest version: ${version}"
echo "BaiduNetdisk latest url: ${url}"
perl -i -pe "s|(?<=ARG APP_URL=).*|${url}|g" ./baidunetdisk/Dockerfile
perl -i -pe "s|(?<=RUN set-cont-env APP_VERSION ).*|\"${version}\"|g" ./baidunetdisk/Dockerfile
if [[ -n $(git status --porcelain) ]]; then
  echo "version=${version}" >> "$GITHUB_OUTPUT"
else
  echo "There is no update."
fi
