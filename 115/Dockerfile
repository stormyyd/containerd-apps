FROM jlesage/baseimage-gui:debian-11-v3.5

ENV LANG=C.UTF-8
ENV APP_NAME="115"
COPY startapp.sh /startapp.sh

RUN \
    apt-get update && \
    apt-get install -y curl ca-certificates fonts-wqy-zenhei locales && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen C.UTF-8

ARG APP_URL=https://down.115.com/client/115pc/lin/115pc_1.0.6.7.deb
RUN \
    curl -sS -L ${APP_URL} -o /tmp/115.deb && \
    dpkg -i /tmp/115.deb && \
    rm -f /tmp/115.deb
