set -e

script_path=$(dirname $(readlink -f $0))

# Install tmux
sudo apt install tmux

# Make .tmp dir for vim
if [ ! -e ~/.tmp ]; then
  mkdir ~/.tmp
fi

# Install scm_breeze
if [ ! -e ~/.scm_breeze ]; then
  git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
fi
~/.scm_breeze/install.sh

if [[ ! -e /usr/local/bin/rg ]]; then
  ripv=0.7.1
  rip=ripgrep-$ripv-x86_64-unknown-linux-musl
  wget https://github.com/BurntSushi/ripgrep/releases/download/$ripv/$rip.tar.gz
  mkdir ~/.bin || true
  tar xf $rip.tar.gz -C ~/.bin
  sudo ln -s "$(realpath ~)/.bin/$rip/rg" /usr/local/bin/rg
  rm $rip.tar.gz
fi

# Install Vim Vundle
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Link vimrc
if [ ! -e ~/.vimrc ]; then
  ln -s $script_path/.vimrc ~/.vimrc
fi

# Install Vundle packages
vim +PluginInstall +qa

# Link tmux.conf
if [ ! -e ~/.tmux.conf ]; then
  ln -s $script_path/.tmux.conf ~/.tmux.conf
fi

rm ~/.gitconfig
ln -s $script_path/.gitconfig ~/.gitconfig

# Source zshrc
if ! grep -q bp_zshrc ~/.zshrc; then
  echo 'source ~/dotfiles/.bp_zshrc' >> ~/.zshrc
fi

# Add 'z' plugin
if ! grep -q 'plugins+=(z)' ~/.zshrc; then
  sed -i 's/^plugins=.\+/\0\nplugins+=(z)/' ~/.zshrc
fi
