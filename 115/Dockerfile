FROM jlesage/baseimage-gui:debian-11-v3.5

ARG APP_URL=https://down.115.com/client/115pc/lin/115pc_1.0.0.16.deb

RUN \
    apt-get update && apt-get install -y curl ca-certificates fonts-wqy-zenhei && \
    curl -sS -L ${APP_URL} -o /tmp/115.deb && dpkg -i /tmp/115.deb && rm -f /tmp/115.deb && \
    rm -rf /var/lib/apt/lists/*

COPY startapp.sh /startapp.sh

ENV APP_NAME="115"

