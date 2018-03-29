" Vundle init /
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'w0rp/ale'

Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'elzr/vim-json'
Plugin 'mxw/vim-jsx'

Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-dispatch'
Plugin 'salomvary/vim-eslint-compiler'
Plugin 'editorconfig/editorconfig-vim'

Plugin 'sirtaj/vim-openscad'
Plugin 'PProvost/vim-ps1'

Plugin 'terryma/vim-multiple-cursors'

" Plugin 'klen/python-mode'
" Plugin 'fisadev/vim-isort'

Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'mileszs/ack.vim'

call vundle#end()
filetype plugin on
" / Vundle init

set rtp+=~/dotfiles/snippets

set hlsearch
set number
set noexpandtab
set ts=4
set sts=4
set sw=4

set ignorecase
set smartcase

set directory=$TEMP//,~/.tmp//.
set backupdir=$TEMP//,~/.tmp//.
set undodir=$TEMP//,~/.tmp//.

set statusline=%f\ %m\ %#warningmsg#\ %*\ %l/%L-%c%V

" Fix terminal weirdness
set t_Co=256
set t_ut=

colorscheme Monokai
autocmd ColorScheme * highlight Search cterm=reverse
highlight Search term=reverse cterm=reverse gui=reverse

augroup filetypedetect
    autocmd BufNew,BufNewFile,BufRead *.md :set filetype=markdown
augroup END

set fdm=indent
set foldignore=
set foldcolumn=2
set colorcolumn=120

set cursorline
set cursorcolumn

" Enable local vimrcs
set exrc
set secure

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

let g:airline_section_b='%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}'
let g:airline_section_x=''
let g:airline_powerline_fonts=1

" Show window numbers in status line
function! WindowNumber()
    let str=tabpagewinnr(tabpagenr())
    return str
endfunction
let g:airline_section_y='win:%{WindowNumber()}'

" Switch to a window number with \\<num>
let i = 1
while i <= 20
    execute 'nnoremap <Leader><Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

map <Leader>s <esc>:wa<CR>
imap <Leader>s <esc>:wa<CR>
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

set updatetime=500

" Diff the unsaved changes in a file with the contents on disk
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

command! Merge /[<=>]\{7}

set relativenumber
set visualbell

" Quick access to NERDTree for the current file's directory
command! Directory e %:h
map <Leader><Leader>d <esc>:Directory<CR>
imap <Leader><Leader>d <esc>:Directory<CR>

let g:NERDTreeIgnore=['\~$', '\.meta$']
let g:NERDSpaceDelims=1

set encoding=utf-8

filetype plugin on

let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_working_path_mode=0
let g:ctrlp_max_files=0

set nowrap
set autoindent
set smartindent

let g:sparkupNextMapping = '<c-d>'

command! -nargs=1 Commit Gwrite | Gcommit -m <q-args>

noremap <C-S> :update<CR>
inoremap <C-S> <C-O>:update<CR>
set clipboard=unnamed

set guifont=Ubuntu\ Mono:h9

" Strip trailing spaces on save
" autocmd BufWritePre * :%s/\s\+$//e

" Use a backup copy instead of renaming files
set backupcopy=yes

hi! def link jsonKeyword Identifier

au FileType qf call AdjustWindowHeight(3, 100)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

let g:ackprg = 'rg --vimgrep'

command! -nargs=+ Rg Ack <args>

let g:ale_javascript_standard_executable = 'node_modules/.bin/semistandard'
let g:ale_javascript_standard_use_global = 1
