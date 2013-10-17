" Vundle init /
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-sensible'

Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'

Bundle 'Lokaltog/vim-easymotion'

Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

Bundle 'scrooloose/syntastic'

Bundle 'tpope/vim-fugitive'
Bundle 'flazz/vim-colorschemes'
Bundle 'pangloss/vim-javascript'

Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
Bundle 'majutsushi/tagbar'

filetype plugin indent on
" / Vundle init

set hlsearch
set number
set expandtab
set ts=4
set sts=4
set sw=4

set ignorecase
set smartcase

set directory=$TEMP//,~/.tmp//.

set statusline=%f\ %m\ %#warningmsg#\ %{SyntasticStatuslineFlag()}\ %*\ %l/%L-%c%V

autocmd BufWritePre * :%s/\s\+$//e

set t_Co=256

set t_ut=

colorscheme Monokai
highlight Search cterm=reverse
