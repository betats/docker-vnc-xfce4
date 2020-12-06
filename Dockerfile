FROM buildpack-deps:buster as getter
# https://ftp.mozilla.org/pub/firefox/releases/latest/README.txt

ENV OS=linux64
ENV LANG=en-US
WORKDIR /mozilla
RUN wget -O Firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=$OS&lang=$LANG"
RUN wget -O Thunderbird.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=$OS&lang=$LANG"
RUN tar xf Firefox.tar.bz2 && rm Firefox.tar.bz2
RUN tar xf Thunderbird.tar.bz2 && rm Thunderbird.tar.bz2

FROM debian:buster

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    libgtk-3-0\
    x11vnc libdbus-glib-1-2 xvfb \
    xfce4 x11-xserver-utils \
    fcitx fcitx-mozc fcitx-frontend-all fcitx-config-gtk fcitx-config-gtk2 fcitx-ui-classic fcitx-ui-light \
    im-config fcitx-frontend-gtk2 fcitx-frontend-gtk3 fcitx-frontend-qt4 fcitx-frontend-qt5 fcitx-module-dbus fcitx-module-kimpanel fcitx-module-lua \
    fonts-noto-cjk dbus-x11 xterm locales \
    libreoffice \
 && rm -rf /var/lib/apt/lists

RUN sed -i 's/..ja_JP.UTF-8/ja_JP.UTF-8/' /etc/locale.gen \
 && locale-gen

RUN useradd -m user -s /bin/bash
USER user

ENV LC_CTYPE ja_JP.UTF-8
ENV GTK_IM_MODULE fcitx
ENV XMODIFIERS @im=fcitx
ENV QT_IM_MODULE fcitx

COPY --from=getter --chown=user:user /mozilla /opt/mozilla

COPY start.sh /

ENTRYPOINT ["/start.sh"]
