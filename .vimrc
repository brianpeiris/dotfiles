"  --
"  -- Vundle Init
"  --
" vint: -ProhibitSetNoCompatible
set nocompatible
" vint: +ProhibitSetNoCompatible
filetype off

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'flazz/vim-colorschemes'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'w0rp/ale'
Plugin 'prettier/vim-prettier'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

Plugin 'itchyny/lightline.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-dispatch'
Plugin 'editorconfig/editorconfig-vim'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'elzr/vim-json'
Plugin 'sirtaj/vim-openscad'
Plugin 'PProvost/vim-ps1'
Plugin 'ap/vim-css-color'
Plugin 'elixir-editors/vim-elixir'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'AndrewRadev/linediff.vim'

Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf.vim'

Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
filetype plugin on

" --
" -- Vim Settings
" --

set runtimepath+=~/dotfiles/snippets
set runtimepath+=~/.fzf

set hlsearch
set number
set relativenumber

set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set ignorecase
set smartcase

set directory=$TEMP//,~/.tmp//.
set backupdir=$TEMP//,~/.tmp//.
set undodir=$TEMP//,~/.tmp//.

" Fix terminal weirdness
set t_Co=256
set t_ut=

colorscheme Monokai
augroup searchhighlight
  autocmd ColorScheme * highlight Search cterm=reverse
augroup END
highlight Search term=reverse cterm=reverse gui=reverse
highlight ColorColumn term=reverse ctermbg=234 guibg=#3c3d37

hi! def link jsonKeyword Identifier

augroup filetypedetect
    autocmd BufNew,BufNewFile,BufRead *.md :set filetype=markdown
augroup END

augroup lightlineupdate
  autocmd User ALELintPre call lightline#update()
  autocmd User ALELintPost call lightline#update()
augroup END

set foldmethod=indent
set foldignore=
set foldcolumn=2
set colorcolumn=120

set cursorline
set cursorcolumn

augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
    au VimEnter * setlocal cursorcolumn
    au WinEnter * setlocal cursorcolumn
    au BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorcolumn
augroup END

" Enable local vimrcs
set exrc
set secure

set updatetime=500

set visualbell

set encoding=utf-8

set nowrap
set autoindent
set smartindent

set clipboard=unnamed

set guifont=Ubuntu\ Mono:h9

" Use a backup copy instead of renaming files
set backupcopy=yes

let g:mapleader=' '

set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$

" --
" -- Commands
" --

" Diff the unsaved changes in a file with the contents on disk
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

command! Merge /[<=>]\{7}

command! Ev :sp ~/.vimrc
command! Rv :source ~/.vimrc

map <Leader>w <esc>:set invlist<CR>
map <Leader>i <esc>:set invpaste<CR>

command! -nargs=1 Commit Gwrite | Gcommit -m <q-args>

command! -nargs=+ Rg Ack! <args>

" Strip trailing spaces on save
" autocmd BufWritePre * :%s/\s\+$//e

function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line('$'), a:maxheight]), a:minheight]) . 'wincmd _'
endfunction
augroup quickfixresize
  autocmd FileType qf call AdjustWindowHeight(3, 100)
augroup END

" --
" -- Mappings
" --

map <Leader>d :e %:h<CR>
map <Leader>s :wa<CR>
map <Leader>hi :noh<CR>
map <Leader>cc <C-w>c
map <Leader>y myggVG"+y`y
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

map <C-p> :FZF<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

noremap <C-S> :update<CR>
inoremap <C-S> <C-O>:update<CR>

" --
" -- Plugin Settings
" --

function! ErrorStatus()
  if ale#linter#Get(&filetype) == []
    highlight ErrorStatus ctermfg=244 ctermbg=236 
    return '- '
  endif
  let l:currBuffer = bufnr('%')
  let l:errorCount = ale#statusline#Count(l:currBuffer)['total']
  let l:linting = ale#engine#IsCheckingBuffer(l:currBuffer)
  if l:linting == 1
    highlight ErrorStatus ctermfg=244 ctermbg=236 
    return " \uf128"
  endif
  if l:errorCount == 0
    highlight ErrorStatus ctermfg=2 ctermbg=236 
    return " \uf00c"
  else
    highlight ErrorStatus ctermfg=236 ctermbg=204 
    return " \uf00d " . l:errorCount . ' ' 
  endif
endfunction

highlight AddStatus ctermfg=2 ctermbg=236
highlight ChangeStatus ctermfg=3 ctermbg=236
highlight DeleteStatus ctermfg=1 ctermbg=236

function! Modified()
  if &modified == 1
    highlight Modified ctermfg=3 ctermbg=236
    return '+'
  else
    highlight Modified ctermfg=245 ctermbg=236
    return '-'
  endif
endfunction

let g:lightline = { 
\ 'colorscheme': 'jellybeans',
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
\ 'active': { 
\   'left': [ ['mode', 'paste'], ['fugitivehead'], ['readonly', 'relativepath', 'mod', 'hunks', 'errors'] ],
\   'right': [ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype', 'winnr'] ] 
\ },
\ 'inactive': { 
\   'left': [ [ 'relativepath', 'mod' ] ],
\   'right': [ ['lineinfo'], ['percent'], ['winnr'] ] 
\ },
\ 'component': {
\   'filename': '%f',
\   'fugitivehead': "\ue725 %{fugitive#head()}",
\   'mod': '%#Modified#%{Modified()}%#LightlineLeft_normal_2#',
\   'hunks': '%#AddStatus#%{fugitive#head()!=""?GitGutterGetHunkSummary()[0]." ":""}
\%#ChangeStatus#%{fugitive#head()!=""?GitGutterGetHunkSummary()[1]." ":"-"}
\%#DeleteStatus#%{fugitive#head()!=""?GitGutterGetHunkSummary()[2]:""}%#LightlineLeft_normal_2#',
\   'errors': '%#ErrorStatus#%{ErrorStatus()}%#LightlineLeft_normal_2#',
\ }
\}

" Switch to a window number with \\<num>
let g:WinNum = 1
while g:WinNum <= 20
    execute 'nnoremap <Leader>' . g:WinNum . ' :' . g:WinNum . 'wincmd w<CR>'
    let g:WinNum = g:WinNum + 1
endwhile

let g:NERDTreeIgnore=['\~$', '\.meta$']
let g:NERDSpaceDelims=1
let g:NERDTreeMapJumpNextSibling=''
let g:NERDTreeMapJumpPrevSibling=''

let g:sparkupNextMapping = '<c-d>'

let g:ackprg = 'rg -S --vimgrep -g "!node_modules"'

let g:ale_javascript_standard_executable = 'node_modules/.bin/semistandard'
let g:ale_javascript_standard_use_global = 1
let g:ale_linters = { 'javascript': ['eslint', 'semistandard'], 'elixir': ['mix'] }
let g:ale_html_htmlhint_executable = 'scripts/lint-html.js'
let g:ale_html_htmlhint_use_global = 1
let g:ale_fixers = { 'elixir': ['mix_format'] }
let g:ale_fix_on_save = 1
