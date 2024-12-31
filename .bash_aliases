# Vi keybindings
set -o vi

export PAGER=less

# Default editor
export EDITOR=vim
export VISUAL=$EDITOR

# Have FZF use fd so that it respects .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix'

# https://github.com/b-ryan/powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Quickly edit and reload aliases
alias ea='vim ~/.bash_aliases'
alias ra='source ~/.bash_aliases'
alias el='vim ~/.local_aliases'

# Access to frequently used text files
alias notes='vim ~/Documents/notes/notes.txt'
alias todo='vim ~/Documents/todo.txt'

# Batcat for colorful cat output
alias ocat='cat'
alias cat='batcat'

# Nicer diff output
alias diff='diff --unified --color=always'

alias rg='rg --smart-case'

# Serve a directory (with live reload)
alias bs='browser-sync start -s -w --no-open --no-notify --no-ghost-mode'

function mcd {
  mkdir $1
  cd $1
}

# Setup SSH keys
function sa {
  eval `ssh-agent -s` > /dev/null
  ssh-add
}

# Git shortcuts
alias fetch='git fetch'
alias push='git push'
alias pull='git pull'
# Override SCM Breeze's alias
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
  git push -u $1 $(gname) ${@:2}
}
alias pushto='pusht origin'
alias gbda='git branch --merged | egrep -v "(^\*|master|main|dev|develop)" | xargs git branch -d'
alias grbo='git rebase origin/master'
alias gskip='git update-index --skip-worktree'
alias gnoskip='git update-index --no-skip-worktree'
alias glsskip='git ls-files -t | rg "^S"'

function grhb {
  fetch
  git reset --hard origin/$(gname)
}

function clone() {
  user=`echo $1 | cut -d'/' -f1`
  repo=`echo $1 | cut -d'/' -f2`
  mkdir $user
  cd $user
  git clone git@github.com:$user/$repo
  cd $repo
}

# Docker shortcuts
alias dc='docker-compose'
alias dce='dc exec'
function dh {
  docker run -it --net host --rm -v "$PWD":/app -w /app $*
}
function clean-docker {
  docker container prune -f
  docker volume prune -f
}

# Node shortcuts
function nv() {
  echo "node $(node --version)"
  echo "npm $(npm --version)"
}
alias ns='npm run start'
alias nd='npm run dev'
alias nr='npm run'

# Tmux shortcuts
function three() {
  tmux split-window -h
  tmux split-window -h
  tmux resize-pane -t0 -x25%
  tmux resize-pane -t1 -x50%
  tmux select-pane -t1
}
function layout() {
  tmux split-window -v
  tmux split-window -h
  tmux resize-pane -t1 -y20
  tmux select-pane -t0
}

function grid() {
  tmux split-window -v
  tmux split-window -v
  tmux resize-pane -t0 -y33%
  tmux resize-pane -t1 -y33%
  tmux resize-pane -t2 -y33%
  tmux split-window -t0 -h
  tmux split-window -t2 -h
  tmux split-window -t4 -h
  tmux select-pane -t0
}

alias trr='tmux resize-pane -y'

alias dus='du -d1 | sort -n'
alias du='dust -d1'

# Misc shortcuts
function naut() {
  nautilus $1 > /dev/null 2>&1 &
}

function enum() {
  local i=1
  while IFS= read -r line; do
    echo "[$i] $line"
    declare -g "e$i=$line"
    ((i++))
  done
}

function e { enum < <(eval "$(fc -ln -1)"); }

alias bell='aplay /usr/share/sounds/sound-icons/piano-3.wav > /dev/null 2>&1'

# Load per-machine aliases
[ -s ~/.local_aliases ] && source ~/.local_aliases
