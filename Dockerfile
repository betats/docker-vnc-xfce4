FROM buildpack-deps:buster as getter
# https://ftp.mozilla.org/pub/firefox/releases/latest/README.txt

ENV OS=linux64
ENV LANG=en-US
WORKDIR /firefox
RUN wget -O Firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=$OS&lang=$LANG"
RUN tar xf Firefox.tar.bz2


FROM debian:buster

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    libgtk-3-0\
    x11vnc libdbus-glib-1-2 xvfb \
    xfce4 \
    fonts-noto-cjk dbus-x11 xterm \
 && rm -rf /var/lib/apt/lists

COPY --from=getter /firefox/firefox /firefox

COPY start.sh /
ENTRYPOINT ["/start.sh"]
