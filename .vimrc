" vim-plug
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-sleuth'
Plug 'dense-analysis/ale'

Plug 'preservim/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdcommenter'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'prettier/vim-prettier'
Plug 'jeetsukumaran/vim-buffergator'

Plug 'HerringtonDarkholme/yats.vim'
Plug 'vim-python/python-syntax'
Plug 'pangloss/vim-javascript'

Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

Plug 'github/copilot.vim'
Plug 'ryvnf/readline.vim'

Plug 'vim-airline/vim-airline'
call plug#end()

set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set nofixeol

set hlsearch

set ignorecase
set smartcase

set autoindent
set smartindent

set linebreak
set breakindent

set number
set relativenumber
set cursorline

set foldmethod=indent
set foldignore=

set clipboard=unnamedplus

set directory=$HOME/.tmp//
set backupdir=$HOME/.tmp//
set undodir=$HOME/.tmp//

set completeopt+=longest

set mouse=

colorscheme Monokai
highlight Search term=reverse cterm=reverse gui=reverse

highlight Checkbox ctermfg=brown
highlight Done ctermfg=green

autocmd BufRead,BufNewFile *.txt syntax match Checkbox /\[ \]/
autocmd BufRead,BufNewFile *.txt syntax match Done /\[x\]/

let mapleader=' '

" vim-python/python-syntax
let g:python_highlight_all = 1

let g:UltiSnipsExpandTrigger="<C-p>"

let g:NERDTreeMapJumpNextSibling=''
let g:NERDTreeMapJumpPrevSibling=''
let g:NERDTreeCustomOpenArgs={'file': {'reuse': '', 'where': 'p'}, 'dir': {}}

let g:gutentags_file_list_command='rg --files'

let g:prettier#config#print_width = '100'

let g:copilot_filetypes = {'text': v:false}

let g:ale_fixers = { 'typescript': ['prettier'], 'typescriptreact': ['prettier'], 'javascript': ['prettier'], 'html': ['prettier'], 'css': ['prettier'], 'json': ['prettier'] }
let g:ale_linters = { 'javascript': ['eslint'], 'typescript': ['eslint'], 'typescriptreact': ['eslint'] }

imap <C-s> <Esc>:write<CR>
map <C-s> :write<CR>

map <C-p> :FZF<CR>
map <C-t> :Tags<CR>

map <Leader>ec :sp $MYVIMRC<CR>
map <Leader>rc :source $MYVIMRC<CR>
map <Leader>es :sp ~/.config/nvim/UltiSnips<CR>
map <Leader>d :e %:p:h<CR>
nmap <Leader>g :Rg \b<C-R>=escape(expand('<cword>'), '\')<CR>\b<CR>
vmap <Leader>g y:Rg <C-R>"<CR>
map <Leader>h :noh<CR>
noremap <Leader>cb i[ ] <Esc>
imap <C-c> [ ] 

map <Leader>p <Plug>(ale_fix)
map <Leader>i :ALEHover<CR>
map <Leader>e :ALEDetail<CR>

command! Merge /[<=>]\{7}
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
command! -nargs=1 Silent execute 'silent !' . <q-args> | execute 'redraw!'
