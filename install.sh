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
sudo add-apt-repository -y ppa:git-core/ppa

banner "update apt"
sudo apt update

banner "install latest git"
sudo apt install -y git

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

banner "install nerd font"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Ubuntu Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf
fc-cache -f -v

banner "install vim"
sudo apt install -y vim

banner "install tmux"
sudo apt install -y tmux

# Make .tmp dir for vim
if [ ! -e ~/.tmp ]; then
  mkdir ~/.tmp
fi

banner "install ruby"
if ! which ruby; then
  sudo apt install -y ruby
fi

banner "install scm breeze"
if [ ! -e ~/.scm_breeze ]; then
  git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
fi
~/.scm_breeze/install.sh

banner "install ripgrep"
if ! rg; then
  wget https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
  sudo dpkg -i ripgrep_0.8.1_amd64.deb
  rm ripgrep_0.8.1_amd64.deb
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
