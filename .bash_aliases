set -o vi

export EDITOR=vim
export VISUAL=$EDITOR

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# https://github.com/b-ryan/powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

alias ea='vim ~/.bash_aliases'
alias ra='source ~/.bash_aliases'
alias el='vim ~/.local_aliases'

alias notes='vim ~/Documents/notes.txt'

alias diff='diff -u --color'

alias rg='rg -S'

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
alias gskip='git update-index --skip-worktree'
alias gnoskip='git update-index --no-skip-worktree'
alias glsskip='git ls -t | rg "^S"'

alias dc='docker-compose'
alias dce='dc exec'

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

function three() {
  tmux split-window -h
  tmux split-window -h
  tmux resize-pane -t0 -x25%
  tmux resize-pane -t1 -x50%
  tmux select-pane -t1
}


[ -s ~/.local_aliases ] && source ~/.local_aliases
