#!/usr/bin/env bash
set -e

function banner() {
  echo ''
  echo '###################################'
  echo " $1 "
  echo '###################################'
  echo ''
}

script_path=$(dirname $(readlink -f $0))

banner "add vim ppa"
sudo add-apt-repository -y ppa:jonathonf/vim

banner "update apt"
sudo apt update

banner "install curl"
if ! which curl; then
  sudo apt install -y curl
fi

if grep -q bash <<<$SHELL; then
  banner "install zsh"
  sudo apt install -y zsh
  banner "installing ohmyzsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

banner "install vim"
sudo apt install -y vim

banner "install tmux"
sudo apt install -y tmux

# Make .tmp dir for vim
if [ ! -e ~/.tmp ]; then
  mkdir ~/.tmp
fi

banner "install scm breeze"
if [ ! -e ~/.scm_breeze ]; then
  git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
fi
~/.scm_breeze/install.sh

banner "install ripgrep"
if [ ! -e $(which rg) ]; then
  sudo snap install rg
fi

banner "install vundle"
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Link vimrc
if [ ! -e ~/.vimrc ]; then
  ln -s $script_path/.vimrc ~/.vimrc
fi

banner "install vim plugins"
vim +PluginInstall +qa

# Link tmux.conf
if [ ! -e ~/.tmux.conf ]; then
  ln -s $script_path/.tmux.conf ~/.tmux.conf
fi

if [ -e ~/.gitconfig ]; then
  rm ~/.gitconfig
fi
ln -s $script_path/.gitconfig ~/.gitconfig

# Source zshrc
if [ -e ~/.zshrc ] && ! grep -q bp_zshrc ~/.zshrc; then
  echo 'source ~/dotfiles/.bp_zshrc' >> ~/.zshrc
fi

# Add 'z' plugin
if ! grep -q 'plugins+=' ~/.zshrc; then
  sed -i 's/^source $ZSH.\+/plugins+=(z git)\n\0/' ~/.zshrc
fi
