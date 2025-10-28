# shellcheck shell=bash

# Bash settings
shopt -s cdspell autocd dirspell extglob checkwinsize huponexit histappend
HISTCONTROL=ignoredups HISTSIZE='' HISTFILESIZE=''

# Zathura
zathura() {
    if [ $# -eq 0 ]; then
        echo "Usage: zathura <document>"
        return 1
    fi
    if [ ! -f "$1" ]; then
        echo "Error: File '$1' not found or is not a regular file"
        return 1
    fi
    if [[ "${1,,}" =~ \.(pdf|ps|eps|djvu|djv|cbr|cbz|cbt|cb7|epub)$ ]]; then
        setsid -f "$(command -v zathura)" "$1" &>/dev/null
        echo "Opening '$1' in zathura"
    else
        echo "Error: '$1' does not have a supported file extension"
        echo "Supported formats: PDF, PS, EPS, DjVu, CBR/CBZ/CBT/CB7, EPUB"
        return 1
    fi
}

# mkcd function
mkcd() {
    if [ $# -ne 1 ]; then
        echo "Usage: mkcd <directory>"
        return 1
    fi
    mkdir -p "$1" && cd "$1" || return 1
}
