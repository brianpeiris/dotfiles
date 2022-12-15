" vim-plug
call plug#begin()
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-sleuth'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'vim-python/python-syntax'
Plug 'SirVer/ultisnips'
Plug 'preservim/nerdcommenter'
call plug#end()

set sts=4
set ts=4
set sw=4
set et
set nofixeol
set hlsearch

set ignorecase
set smartcase

set number
set relativenumber

set fdm=indent

set cursorline

colorscheme Monokai
highlight Search term=reverse cterm=reverse gui=reverse

let mapleader=' '

" vim-python/python-syntax
let g:python_highlight_all = 1

let g:NERDTreeMapJumpNextSibling=''
let g:NERDTreeMapJumpPrevSibling=''

imap <C-s> <Esc>:write<CR>
map <C-s> :write<CR>

map <C-p> :FZF<CR>

map <Leader>ec :sp $MYVIMRC<CR>
map <Leader>rc :source $MYVIMRC<CR>
map <Leader>es :sp ~/.config/nvim/UltiSnips<CR>
map <Leader>d :e %:h<CR>
map <Leader>g :Rg \b<C-R><C-W>\b<CR>
map <Leader>n :noh<CR>

command! Merge /[<=>]\{7}
command! DiffOrig vert new | set bt=nofile | r
