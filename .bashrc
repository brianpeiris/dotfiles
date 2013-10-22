[ -s ".bashrc_base" ] && source .bashrc_base

export PATH=$HOME/local/bin:$PATH

if [ "$TMUX" = "" ]; then
    tmux
fi

export TERM=screen-256color

[ -s "/home/brianpeiris/.scm_breeze/scm_breeze.sh" ] && source "/home/brianpeiris/.scm_breeze/scm_breeze.sh"

md () { mkdir -p "$@" && cd "$@"; }
