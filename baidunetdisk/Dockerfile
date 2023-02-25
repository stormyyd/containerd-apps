FROM jlesage/baseimage-gui:debian-11-v4

LABEL org.opencontainers.image.authors="storm-yyd@outlook.com"

RUN set-cont-env APP_NAME "Baidu Netdisk"
RUN set-cont-env APP_VERSION "4.17.7"

COPY startapp.sh /startapp.sh
COPY main-window-selection.jwmrc /etc/jwm/main-window-selection.jwmrc

RUN add-pkg \
    curl ca-certificates fonts-wqy-zenhei locales \
    libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 libuuid1 libsecret-1-0 libgbm-dev \ 
    libasound2 libx11-xcb1

RUN sed-patch 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8

ARG APP_URL=https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/4.17.7/baidunetdisk_4.17.7_amd64.deb
RUN \
    curl -sS -L ${APP_URL} -o /tmp/baidunetdisk.deb && \
    dpkg -i /tmp/baidunetdisk.deb && \
    rm -f /tmp/baidunetdisk.deb
