#!/usr/bin/env bash
if [[ "$(tty)" == /dev/tty* ]]; then
  PS1='\[\e[96m\]prompt \[\e[0m\]'
else
  PS1='🍺 '
fi
