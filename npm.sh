#!/bin/sh

case $1 in 
  docs | faq | find | home | i | info | install | isntall | issues | rb | rebuild | repo | s | se | search | v | view) cnpm "$@" ;;
  *) npm "$@" ;;
esac
