FROM jlesage/baseimage-gui:debian-11-v4

LABEL org.opencontainers.image.authors="storm-yyd@outlook.com"

ARG APT_SOURCE=http://deb.debian.org/debian

RUN set-cont-env APP_NAME "115"
RUN set-cont-env APP_VERSION "2.0.6.6"

COPY startapp.sh /startapp.sh
COPY main-window-selection.jwmrc /etc/jwm/main-window-selection.jwmrc

RUN sed -i "s|http://deb.debian.org/debian|${APT_SOURCE}|g" /etc/apt/sources.list && \
    add-pkg curl ca-certificates fonts-wqy-zenhei locales libgl1 libglib2.0-0

RUN sed-patch 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8

ARG APP_URL=https://down.115.com/client/115pc/lin/115pc_2.0.6.6.deb
RUN \
    curl -sS -L ${APP_URL} -o /tmp/115.deb && \
    dpkg -i /tmp/115.deb && \
    rm -f /tmp/115.deb
