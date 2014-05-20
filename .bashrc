[ -s "$HOME/.bashrc_base" ] && source "$HOME/.bashrc_base"

export PATH=$HOME/local/bin:$PATH

if [ "$TMUX" = "" ]; then
    tmux
fi

export TERM=screen-256color

[ -s "/home/brianpeiris/.scm_breeze/scm_breeze.sh" ] && source "/home/brianpeiris/.scm_breeze/scm_breeze.sh"

md () { mkdir -p "$@" && cd "$@"; }

# disable flow control
stty -ixon

alias _git_current_branch="git rev-parse --abbrev-ref HEAD"
alias pull='git pull origin $(_git_current_branch)'
alias push='git push origin $(_git_current_branch)'
