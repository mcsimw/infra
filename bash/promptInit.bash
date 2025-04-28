#!/usr/bin/env bash

# ── colour helper (readline counts width = 0) ───────────────
c() { printf '\001\033[%sm\002' "$1"; }

rst=$(c 0)
usr=$(c 35) ats=$(c 90) hst=$(c 36) dir=$(c 37) brn=$(c 33)
sym_root=$(c 31)'#' sym_user=$(c 32)'\$'

base="${usr}\\u${rst}${ats}@${rst}${hst}\\h${rst} ${dir}\\w${rst}"

git_branch_prompt() {
  local b
  b=$(git -C . rev-parse --abbrev-ref HEAD 2>/dev/null) || return
  [[ $b == HEAD || -z $b ]] && return
  printf ' %s(%s)%s' "$brn" "$b" "$rst"
}

# Build the literal string  $(git_branch_prompt)
#   '$'  in one quoted chunk, '(git_branch_prompt)' in another ⇒ no $(…) inside quotes
branch_cmd='$''(git_branch_prompt)'

if ((EUID == 0)); then
  PS1="${base}${branch_cmd}\n${sym_root}${rst} "
else
  PS1="${base}${branch_cmd}\n${sym_user}${rst} "
fi
export PS1
