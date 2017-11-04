script_path=$(dirname $(readlink -f $0))

# Make .tmp dir for vim
if [ ! -e ~/.tmp ]; then
  mkdir ~/.tmp
fi

# Install scm_breeze
if [ ! -e ~/.scm_breeze ]; then
  git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
fi
~/.scm_breeze/install.sh

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
