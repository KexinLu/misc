behave xterm

" variable setup

set nocompatible
" ------------------------------adding plugin here -------------------------
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'stuartherbert/vim-phix-colors'
call vundle#end()
filetype plugin indent on

" for nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>


" for colorschema
Plugin 'flazz/vim-colorschemes'
Plugin 'modess/vim-phpcolors'
Plugin 'Shutnik/jshint2.vim'

" ------------------------------------plug in finish--------------------------------
set modeline    " read mode line
set expandtab
set shiftwidth=4        " indent 4 spaces
set fdm=manual
set softtabstop=4       " tabstop 4 spaces
set ruler
set textwidth=0
set showmatch
set autoindent
set visualbell
set showfulltag
set hlsearch
set undolevels=1000 "explicitly state default, just in case...
set backspace=indent,eol,start
set updatetime=2000
set ignorecase          " ignore case in search patterns ...
set smartcase           " ... unless pattern contains uppercase
set title titlestring=%F%M%R
set statusline=%F%m%r%h%w%y%=%l,%c%V\ (%3b=0x%02B)\ %P
set scrolloff=2
set incsearch           " do incremental searching
set listchars=tab:^.,trail:¦


" keymappings --------------------------------------

map Q :nohlsearch<CR>

syntax on

map ,d :!git diff % <CR>

imap jj <Esc>

noremap <S-Enter> O<Esc>

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi

" keymappings end here -----------------------------

syntax enable
set background=dark
colorscheme phix
if has("mouse")
set mouse=v
endif

set clipboard^=unnamed
" If comparing files side-by-side, then ...
if &diff
    " double the width up to a reasonable maximum
    let &columns = ((&columns*2 > 172)? 172: &columns*2)

        " add bottom scrollbar
        set guioptions=agimrb
endif



syn sync fromstart

set helplang=en
set scroll=25
set ttyfast
set ttymouse=xterm2
set novisualbell
set smartindent
set nu
set smarttab
set laststatus=2
set nowrapscan
set nowrap

au BufRead,BufNewFile *.t           set filetype=perl
au BufRead,BufNewFile *.ctp         set filetype=html
au BufRead,BufNewFile *.tal         set filetype=html

set tabstop=8
set shiftround
set matchpairs+=<:>
set term=linux

set novb
set t_Co=256

autocmd BufWritePre * :%s/\s\+$//e


cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

" adding functions below

function! Search(...)
    let args=split(a:1)
    if len(args) == 2
        let dir=args[1]
    else
        let dir='.'
    endif
    echom args[0] . "  " . shellescape(dir)
endfunction
com! -nargs=? GrepTab call s:NewTabGrep('<args>')
