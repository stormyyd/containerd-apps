FROM jlesage/baseimage-gui:debian-11-v3.5

ARG APP_URL=https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.3.0/baidunetdisk_4.3.0_amd64.deb

RUN \
    apt-get update && apt-get install -y \
        curl ca-certificates fonts-wqy-zenhei \
        libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 libuuid1 libsecret-1-0 libgbm-dev libasound2 && \
    curl -sS -L ${APP_URL} -o /tmp/baidunetdisk.deb && dpkg -i /tmp/baidunetdisk.deb && rm -f /tmp/baidunetdisk.deb && \
    rm -rf /var/lib/apt/lists/*

COPY startapp.sh /startapp.sh

ENV APP_NAME="Baidu Netdisk"

