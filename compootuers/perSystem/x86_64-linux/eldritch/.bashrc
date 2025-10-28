# shellcheck shell=bash
shopt -s cdspell autocd dirspell extglob checkwinsize huponexit histappend
HISTCONTROL=ignoredups HISTSIZE='' HISTFILESIZE=''

# Zathura
_ZATHURA_VALID_EXTS="pdf|ps|eps|djvu|djv|cbr|cbz|cbt|cb7|epub"
zathura() {
    if [ $# -eq 0 ]; then
        echo "Usage: zathura <document>"
        return 1
    fi
    if [ ! -f "$1" ]; then
        echo "Error: File '$1' not found or is not a regular file"
        return 1
    fi
    if [[ "${1,,}" =~ \.(${_ZATHURA_VALID_EXTS})$ ]]; then
        nohup "$(command -v zathura)" "$1" &>/dev/null & disown
        echo "Zathura opened in the background with: $1"
    else
        echo "Error: '$1' is not a valid document type for zathura"
        echo "Supported formats: PDF, PS, EPS, DjVu, CBR/CBZ/CBT/CB7, EPUB"
        return 1
    fi
}
_zathura_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local IFS=$'\n'
    local pattern="*.@(pdf|ps|eps|djvu|djv|cbr|cbz|cbt|cb7|epub|PDF|PS|EPS|DJVU|DJV|CBR|CBZ|CBT|CB7|EPUB)"

    mapfile -t COMPREPLY < <(compgen -f -X "!$pattern" -- "$cur")
    mapfile -t -O "${#COMPREPLY[@]}" COMPREPLY < <(compgen -d -- "$cur")
}
complete -r zathura 2>/dev/null
complete -o filenames -F _zathura_completion zathura
