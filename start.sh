#!/bin/sh
Xvfb :1 -screen 0 1600x900x24 &
/usr/bin/x11vnc -display :1.0 -nopw &
DISPLAY=:1.0 startxfce4
#DISPLAY=:1.0 firefox
