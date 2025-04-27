#!/usr/bin/env bash

if [[ "$(tty)" == /dev/tty[0-9]* ]]; then
  if ((EUID == 0)); then
    PS1='\[\e[35m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]# '
  else
    PS1='\[\e[35m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]$ '
  fi
else
  if ((EUID == 0)); then
    PS1='\[\e[35m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]😈 '
  else
    PS1='\[\e[35m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]🍺 '
  fi
fi

export PS1
