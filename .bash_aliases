set -o vi

export EDITOR=vim
export VISUAL=$EDITOR

source /usr/share/doc/fzf/examples/key-bindings.bash

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PS1="\[\033[38;5;4m\]\W\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

alias ea='vim ~/.bash_aliases'
alias ra='source ~/.bash_aliases'

alias trr='tmux resize-pane -y'

alias bs='browser-sync start -s -w --no-open --no-notify --no-ghost-mode --directory'

function mcd {
  mkdir $1
  cd $1
}

function sa {
  eval `ssh-agent -s` > /dev/null
  ssh-add
}

alias fetch='git fetch'
alias push='git push'
alias pull='git pull'
unalias gcm > /dev/null 2>&1
function gcm {
  git commit -m "$*"
}
function gcam {
  git commit -am "$*"
}
alias gca='git commit --amend'
alias gcne='git commit --amend --no-edit'
alias gname='git rev-parse --abbrev-ref HEAD'
function pusht {
  git push -u $1 $(gname)
}
alias pushto='pusht origin'
alias gbda='git branch --merged | egrep -v "(^\*|master|main|dev)" | xargs git branch -d'
alias grbo='git rebase origin/master'

function naut() {
  nautilus $1 > /dev/null 2>&1 &
}

function clone() {
  user=`echo $1 | cut -d'/' -f1`
  repo=`echo $1 | cut -d'/' -f2`
  mkdir $user
  cd $user
  git clone git@github.com:$user/$repo
  cd $repo
}

function nv() {
  echo "node $(node --version)"
  echo "npm $(npm --version)"
}
alias ns='npm run start'

alias bell='aplay /usr/share/sounds/sound-icons/piano-3.wav > /dev/null 2>&1'
