" Vundle init /
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'tpope/vim-sensible'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

Plugin 'Lokaltog/vim-easymotion'

Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

Plugin 'scrooloose/syntastic'

Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'pangloss/vim-javascript'

Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-dispatch'

Plugin 'klen/python-mode'

Plugin 'rking/ag.vim'

call vundle#end()
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

augroup filetypedetect
    autocmd BufNew,BufNewFile,BufRead *.md :set filetype=markdown
augroup END

let g:ctrlp_clear_cache_on_exit=0

set fdm=indent
set foldignore=
set foldcolumn=2
set colorcolumn=80

set cursorline
set cursorcolumn

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

function! WindowNumber()
    let str=tabpagewinnr(tabpagenr())
    return str
endfunction

let g:airline_section_y='win:%{WindowNumber()}'

let i = 1
while i <= 20
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

let NERDTreeIgnore = ['\.pyc$']
map <Leader>s <esc>:wa<CR>
imap <Leader>s <esc>:wa<CR>
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

set wildignore='*.pyc'

let g:syntastic_auto_loc_list=1
autocmd CursorHold *.py PymodeLint
autocmd CursorHoldI *.py PymodeLint
set updatetime=1000

command! -nargs=+ Agl Ag --ignore-dir=.sass-cache --ignore-dir=_generated_media --ignore-dir=.ropeproject --ignore-dir=bower_components --ignore-file=is:.tags --ignore-file=is:tags <args>

command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

set relativenumber
set visualbell
let g:pymode_rope_complete_on_dot=0

command! Directory e %:h
map <Leader><Leader>d <esc>:Directory<CR>
imap <Leader><Leader>d <esc>:Directory<CR>

set guifont=Ubuntu\ Mono\ 8
highlight Search term=reverse cterm=reverse gui=reverse
