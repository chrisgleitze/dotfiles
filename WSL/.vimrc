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

" Vim in Tmux in Alacritty doesn't show the cursor how I want,
" so I need this to fix it :/
" https://vim.fandom.com/wiki/Configuring_the_cursor
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
    let &t_SI .= "\e[5 q" " SI = INSERT mode
    let &t_SR .= "\e[3 q" " SR = REPLACE mode
    let &t_EI .= "\e[1 q" " EI = NORMAL mode (ELSE)
    " Initialize cursor shape/color on startup
    augroup reset_cursor_shape
    au!
    "autocmd VimEnter * startinsert | stopinsert
    autocmd VimEnter * normal! :startinsert :stopinsert
    "autocmd VimEnter * :normal :startinsert :stopinsert
    autocmd VimEnter * redraw!
    augroup END

    " Reset cursor when Vim exits:
    autocmd VimLeave * silent !echo -ne "\e[5 q"

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

set background=dark
" colorscheme elflord

" set guicursor=n-v-ve-o-r-c-cr-sm:block-blinkon175
" set guicursor=i-ci:ver25-blinkon175
" set guicursor=n-v-ve-o-r-c-cr-sm:block-blinkon175,i-ci:ver25-blinkon175


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make sure there's no other mapping for <space> and set <space> as mapleader
nnoremap <SPACE> <Nop>
let mapleader=" "

" move visual block selection up and down with Ctrl-j and Ctrl-k
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Make Y behave like C and D - copy text until end of line
nmap <silent> Y y$

" Delete all trailing whitespaces
nmap <silent> <leader>tw :%s/\s\+$//<CR>:let @/=''<CR>``

" alternative to get rid of trailing whitespaces:
" issue autocmd on safe to del trailing whitespace
" autocmd BufWritePre * :%s/\s\+$//e

" Move around splits with <C-[hjkl]> in normal mode
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
