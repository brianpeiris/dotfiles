" vim-plug
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-sleuth'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'vim-python/python-syntax'
Plug 'SirVer/ultisnips'
Plug 'preservim/nerdcommenter'
Plug 'ludovicchabant/vim-gutentags'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

set sts=4
set ts=4
set sw=4
set et
set nofixeol
set hlsearch

set ignorecase
set smartcase
set autoindent
set smartindent
set lbr
set breakindent

set number
set relativenumber

set fdm=indent
set clipboard=unnamedplus

set cursorline

set directory=$HOME/.tmp//
set backupdir=$HOME/.tmp//
set undodir=$HOME/.tmp//

colorscheme Monokai
highlight Search term=reverse cterm=reverse gui=reverse

let mapleader=' '

" vim-python/python-syntax
let g:python_highlight_all = 1

let g:NERDTreeMapJumpNextSibling=''
let g:NERDTreeMapJumpPrevSibling=''

let g:lsp_document_code_action_signs_enabled=0
let g:lsp_diagnostics_virtual_text_insert_mode_enabled=0
let g:lsp_diagnostics_virtual_text_enabled=1

let g:gutentags_file_list_command='rg --files'

imap <C-s> <Esc>:write<CR>
map <C-s> :write<CR>

map <C-p> :FZF<CR>
map <C-t> :Tags<CR>

map <Leader>ec :sp $MYVIMRC<CR>
map <Leader>rc :source $MYVIMRC<CR>
map <Leader>es :sp ~/.config/nvim/UltiSnips<CR>
map <Leader>d :e %:p:h<CR>
nmap <Leader>g :Rg \b<C-R><C-W>\b<CR>
vmap <Leader>g y:Rg <C-R>"<CR>
map <Leader>h :noh<CR>

map <Leader>n :LspRename<CR>
map <Leader>i :LspHover<CR>
map <Leader>s :LspDefinition<CR>
map <Leader>p :LspPeekDefinition<CR>
map <Leader>r :LspReferences<CR>

command! Merge /[<=>]\{7}
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
