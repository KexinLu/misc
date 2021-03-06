" ------------------------------ Plugins::Begin ------------------------------
filetype off
filetype plugin indent off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'Shutnik/jshint2.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'modess/vim-phpcolors'
Plugin 'stuartherbert/vim-phix-colors'
Plugin 'yegappan/mru'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-eunuch'
Plugin 'StanAngeloff/php.vim'
Plugin 'tpope/vim-commentary'
" Plugin 'beanworks/vim-phpfmt'
call vundle#end()
filetype plugin indent on
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'tpope/vim-fugitive'

" for nerd tree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>
" ------------------------------- Plugins::End -------------------------------

set modeline        " read mode line
set expandtab
set shiftwidth=4    " indent 4 spaces
set fdm=manual
set softtabstop=4   " tabstop 4 spaces
set ruler
set textwidth=0
set showmatch
set autoindent
set visualbell
set showfulltag
set hlsearch
set undolevels=1000 "explicitly state default, just in case...
set splitbelow
set splitright

set backspace=indent,eol,start
set updatetime=2000
set ignorecase      " ignore case in search patterns ...
set smartcase       " ... unless pattern contains uppercase
set title titlestring=%F%M%R
set statusline=%F%m%r%h%w%y%=%l,%c%V\ (%3b=0x%02B)\ %P
set scrolloff=2
set incsearch       " do incremental searching
set listchars=tab:^.,trail:�

" ------------------------------ KeyMappings::Begin ------------------------------
map Q :nohlsearch<CR>

inoremap <C-@> <CR>
inoremap `nn <C-O>o
cnoremap <C-@> <CR>
nnoremap <C-@> <CR>
nnoremap <C-h> b
nnoremap <C-l> w
nnoremap <C-j> 5j
nnoremap <C-k> 5k
vnoremap <C-@> <CR>

vnoremap <C-h> b
vnoremap <C-l> w
vnoremap <C-j> 5j
vnoremap <C-k> 5k
vnoremap <Tab> :<c-u>call Tab()<CR>gv

cnoremap <C-c> :call CopyLines() <CR>
nnoremap <C-c> :call CopyLines() <CR>
inoremap <C-c> <esc> :call CopyLines() <CR>
vnoremap <C-c> <esc> :call CopyLines() <CR>
nnoremap <space>' ciw'<c-r>"'<esc>
vnoremap <space>' c'<c-r>"'<esc>
nnoremap <space>" ciw"<c-r>""<esc>
vnoremap <space>" c"<c-r>""<esc>
nnoremap <space>[ ciw[<c-r>"]<esc>
vnoremap <space>[ c[<c-r>"]<esc>
nnoremap <space>{ ciw{<c-r>"}<esc>
vnoremap <space>{ c{<c-r>"}<esc>
nnoremap <space>( ciw(<c-r>")<esc>
vnoremap <space>( c(<c-r>")<esc>
" nnoremap <C-m> :call PhpMock() <CR>
vnoremap <Tab> :call VTab() <CR>
nnoremap <Tab> :call Tab() <CR>
syntax on

map ,d :!git diff % <CR>
map ,b :!git blame % <CR>

imap jj <Esc>

nnoremap <f3> :!ctags -R<CR>
" nnoremap <C-j> :m .+1<CR>==
" nnoremap <C-k> :m .-2<CR>==
" inoremap <C-j> <Esc>:m .+1<CR>==gi
" inoremap <C-k> <Esc>:m .-2<CR>==gi
" ------------------------------- KeyMappings::End -------------------------------

syntax enable
set background=dark
set nohidden                  " When I close a tab, remove the buffer
"- set cursorline                " Highlight current line
"- set cursorcolumn              " Highlight current column
"- colorscheme candyman
"- colorscheme molokai
colorscheme phix
"- hi LineNr ctermfg=darkgrey
"- hi CursorLine term=bold cterm=bold guibg=Grey40
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

" ------------------------------ Functions::Start ------------------------------
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

function! CopyLines()
   let startingLine = input('start: ')
   let endLine = input('end: ')
   exe ":" . startingLine.',' . endLine . "t."
endfunction

function! VTab()
    let col = col(".")
    let line = line(".")
            normal! v%
            " slient! exe %
    if (col == col(".") && line == line("."))
            normal! v$
            " slient! exe $
    endif
endfunction

function! Tab()
    let col = col(".")
    let line = line(".")
            normal! %
    if (col == col(".") && line == line("."))
            normal! $
    endif
endfunction

function! PhpMock()
    r~/.vim/phpMock
endfunction
" ------------------------------- Functions::End -------------------------------

" >>>>> go-vim >>>>>
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"

filetype plugin indent on
autocmd FileType python setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType go setlocal tabstop=8 noexpandtab
autocmd FileType make setlocal tabstop=4 noexpandtab

" >>>>> php.vim >>>>>
" let g:php_syntax_extensions_enabled = []
" let b:php_syntax_extensions_enabled = []

function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
augroup END

let g:phpfmt_command = 'docker exec bean_api_1 bin/phpcbf'
let g:phpfmt_options = '--standard=app/BeanPHPStyle.xml --colors --encoding=utf-8'
let g:phpfmt_tmp_dir = 'app/tmp/vim/'
let g:syntastic_always_populate_loc_list = 1
