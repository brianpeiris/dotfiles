" vim-plug
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tanvirtin/monokai.nvim'
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
Plug 'jeetsukumaran/vim-buffergator'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

colorscheme monokai_soda

highlight Checkbox ctermfg=brown
highlight Done ctermfg=green

autocmd BufRead,BufNewFile *.txt syntax match Checkbox /\[ \]/
autocmd BufRead,BufNewFile *.txt syntax match Done /\[x\]/

let mapleader=' '

let g:UltiSnipsExpandTrigger="<C-p>"

let g:NERDTreeMapJumpNextSibling=''
let g:NERDTreeMapJumpPrevSibling=''
let g:NERDTreeCustomOpenArgs={'file': {'reuse': '', 'where': 'p'}, 'dir': {}}

let g:copilot_filetypes = {'text': v:false}

let g:ale_fixers = { 'css': ['prettier'], 'html': ['prettier'], 'javascript': ['prettier'], 'javascriptreact': ['prettier'], 'json': ['prettier'], 'typescript': ['prettier'], 'typescriptreact': ['prettier'] }
let g:ale_linters = { 'javascript': ['eslint'], 'typescript': ['eslint', 'tsserver'], 'typescriptreact': ['eslint', 'tsserver'] }

imap <C-s> <Esc>:write<CR>
map <C-s> :write<CR>

map <C-p> :FZF<CR>

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

lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}
lua require'monokai'.setup{custom_hl_groups={Search={fg='#000000',bg='#FF0000',style='reverse'}}}
