call plug#begin()

" Plugins
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable compatibility with vi which can cause unexpected issues
set nocompatible

" enable type file detection. Vim will be able to try to detect the type of file in use
filetype on

" enable plugins and load plugin for the detected file type
filetype plugin on

" load an indent file for the detected file type
filetype indent on

" turn syntax highlighting on
syntax on

" faster syntax highlighting
syntax sync minlines=256

" set guicursor=n-v-c:block-Cursor
set guicursor=n-v-c-sm-a:block

" set absolute number for current line, relative numbers for all other lines
set nu
set rnu

set linebreak
set mouse=a

" creation of swapfiles and backup files
set noswapfile
set nobackup
set noundofile

" search
set ignorecase
set incsearch
set hlsearch

set scrolloff=10

colorscheme slate

" always display status line
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make sure there's no other mapping for <space> and set <space> as mapleader
nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap <Leader>Q :wqa!<CR>
nnoremap <Leader>W :w<CR>
nnoremap <Leader>S :source<CR>
nnoremap <Leader>n :enew<CR>
nnoremap <Leader>DB :bdelete<CR>

" make Y behave like C and D - copy text until end of line
nmap <silent> Y yg_

" delete all trailing whitespaces
nmap <silent> <leader>tw :%s/\s\+$//<CR>:let @/=''<CR>``

" go to previous, next ... buffer
nnoremap <Leader>j :bprevious<CR>
nnoremap <Leader>k :bnext<CR>
nnoremap <Leader>h :bfirst<CR>
nnoremap <Leader>l :blast<CR>

" buffer list
nnoremap <C-b> :ls<CR>:b<Space>

" center scroll up and down
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" move line up and down with Ctrl-k/j
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" netrw
let g:netrw_liststyle = 3

" fugitive.vim
nmap <leader>gb :Git blame<CR>
nmap <leader>gs :Git<CR>
nmap <leader>gm :Gsplit main:%<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline=%<\ %{mode()}\ \|\ %f%m
set statusline+=%{&paste?'\ \ \|\ PASTE\ ':'\ '}
set statusline+=%=\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}\ \|\ %l/%L\(%c\)\
