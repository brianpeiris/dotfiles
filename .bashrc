[ -s "$HOME/.bashrc_base" ] && source "$HOME/.bashrc_base"

export PATH=$HOME/local/bin:$PATH

if [ "$TMUX" = "" ]; then
    tmux
fi

export TERM=screen-256color

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

md () { mkdir -p "$@" && cd "$@"; }

# disable flow control
stty -ixon

alias _git_current_branch="git rev-parse --abbrev-ref HEAD"
alias pull='git pull origin $(_git_current_branch)'
alias push='git push origin $(_git_current_branch)'

export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

source /usr/local/bin/virtualenvwrapper.sh

ludicrous-speed () {
    for i in {0..7};
    do
        echo ''
        cpufreq-info -c $i | ack -i --nocolor 'current cpu' | sed 's/^\s\+//g'
        echo "Setting cpu $i to ludicrous speed.";
        sudo cpufreq-set -c $i -g 'performance';
        cpufreq-info -c $i | ack -i --nocolor 'current cpu' | sed 's/^\s\+//g'
    done
}
