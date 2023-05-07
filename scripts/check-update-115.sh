#!/usr/bin/env bash

set -e

metadata=$(curl -s \
  -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36" \
  -e "https://115.com" \
  "https://appversion.115.com/1/web/1.0/api/chrome")
version=$(echo ${metadata} | jq -r ".data.linux_115.version_code")
url=$(echo ${metadata} | jq -r ".data.linux_115.version_url")
echo "115 latest version: ${version}"
echo "115 latest url: ${url}"
perl -i -pe "s|(?<=ARG APP_URL=).*|${url}|g" ./115/Dockerfile
perl -i -pe "s|(?<=RUN set-cont-env APP_VERSION ).*|\"${version}\"|g" ./115/Dockerfile
if [[ -n $(git status --porcelain) ]]; then
  echo "version=${version}" >> "$GITHUB_OUTPUT"
else
  echo "There is no update."
fi
