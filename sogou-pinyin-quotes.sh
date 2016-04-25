#!/bin/sh

# Use `「、」、『、』`  in Sogou Pinyin via phrase customization.

PHRASES_DB='/usr/share/fcitx-sogoupinyin/SogouInput/Phrases.ini'

addline() {
  echo "$1" | iconv -t utf-16 >> $PHRASES_DB
}

addline "yy,1=「"
addline "yh,1=」"
addline "qq,1=『"
addline "qt,1=』"

fcitx -r
