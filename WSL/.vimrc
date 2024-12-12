" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" set absolute number for current line, relative numbers for all other lines
set nu
set rnu

" creation of swapfiles and backup files
set noswapfile
set nobackup
set undofile

" search
set ignorecase
set incsearch
set hlsearch

set scrolloff=10
set cursorline

" set background=dark
" colorscheme elflord

set guicursor=n-v-ve-o-r-c-cr-sm:block-blinkon175
" set guicursor=i-ci:ver25-blinkon175
" set guicursor=n-v-ve-o-r-c-cr-sm:block-blinkon175,i-ci:ver25-blinkon175


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make sure there's no other mapping for <space>
" set <space> as mapleader
nnoremap <SPACE> <Nop>
let mapleader=" "

" move visual block selection up and down with Ctrl-j and Ctrl-k
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
