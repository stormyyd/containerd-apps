FROM jlesage/baseimage-gui:debian-11-v3.5

ENV LANG=C.UTF-8
ENV APP_NAME="Baidu Netdisk"
COPY startapp.sh /startapp.sh

RUN \
    apt-get update && \
    apt-get install -y \
        curl ca-certificates fonts-wqy-zenhei locales \
        libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 libuuid1 libsecret-1-0 libgbm-dev libasound2 && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen C.UTF-8

ARG APP_URL=https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.10.5/baidunetdisk_4.10.5_amd64.deb
RUN \
    curl -sS -L ${APP_URL} -o /tmp/baidunetdisk.deb && \
    dpkg -i /tmp/baidunetdisk.deb && \
    rm -f /tmp/baidunetdisk.deb
