set -o errexit
set -o nounset
set -o pipefail

shopt -s globstar
shopt -s dotglob
shopt -s extglob

HISTCONTROL=ignoredups:erasedups
HISTSIZE=
HISTFILESIZE=
HISTTIMEFORMAT='%F %T'
