shopt -s autocd

HISTSIZE=
HISTFILESIZE=

git_branch() {
  local branch
  branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

  local state=""
  if [[ -n $branch ]]; then
    if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
      state="🍆"
    else
      state="🍑"
    fi
    printf "%s%s " "$branch" "$state"
  fi
}

PS1="\[\e[35m\]\u🫀\[\e[36m\]\h\[\e[0m\] 👉👌\[\e[97m\]\W\[\e[95m\] \$(git_branch)\[\e[0m\]🫦"
