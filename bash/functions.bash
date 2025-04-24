cm() {
  if [[ -z $1 ]]; then
    echo "Usage: cm <directory>"
    return 1
  fi

  mkdir -p -- "$1" && cd -P -- "$1" || return
}

# bullshit
:q() { exit; }
h() { history; }

rmf() { rm -rf -- "$@"; }

myip() { curl -s ifconfig.me; }

# Windows
cls() { clear; }
ipconfig() { ip a; }

up() {
  local depth=${1:-1}

  if (($# > 1)); then
    echo "Usage: up [depth]"
    return 1
  fi

  if ! [[ $depth =~ ^[0-9]+$ ]]; then
    echo "Invalid depth: $depth"
    return 1
  fi

  cd "$(printf '../%.0s' $(seq 1 "$depth"))" || return
}

extract() { [[ -f $1 ]] && case "$1" in
*.tar.bz2) tar xvjf "$1" ;;
*.tar.gz) tar xvzf "$1" ;;
*.tar.xz) tar xJf "$1" ;;
*.tar) tar xvf "$1" ;;
*.tbz2) tar xvjf "$1" ;;
*.tgz) tar xvzf "$1" ;;
*.zip) unzip "$1" ;;
*.rar) unrar x "$1" ;;
*.7z) 7z x "$1" ;;
*.gz) gunzip "$1" ;;
*.bz2) bunzip2 "$1" ;;
*) echo "Unknown format: $1" ;;
esac }

cpu() { grep -m1 'model name' /proc/cpuinfo; }

whatos() {
  if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    echo "$NAME $VERSION"
  elif type lsb_release >/dev/null 2>&1; then
    lsb_release -d | cut -f2-
  else
    echo "Unable to determine your OS, but here's the kernel — maybe it'll cheer you up:"
    uname -a
  fi
}
