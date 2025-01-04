call plug#begin()

" List your plugins here
Plug 'tpope/vim-surround'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Options 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable compatibility with vi which can cause unexpected issues.
set nocompatible

" enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" enable plugins and load plugin for the detected file type.
filetype plugin on

" load an indent file for the detected file type.
filetype indent on

" turn syntax highlighting on.
syntax on

" faster syntax highlighting
syntax sync minlines=256

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

" always display status line
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make sure there's no other mapping for <space> and set <space> as mapleader
nnoremap <SPACE> <Nop>
let mapleader=" "

" move around splits with <C-[hjkl]> in normal mode
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" move visual block selection up and down with Ctrl-j and Ctrl-k
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" make Y behave like C and D - copy text until end of line
nmap <silent> Y y$
      
" delete all trailing whitespaces
nmap <silent> <leader>tw :%s/\s\+$//<CR>:let @/=''<CR>``

" alternative to get rid of trailing whitespaces:
" issue autocmd on safe to del trailing whitespace
" autocmd BufWritePre * :%s/\s\+$//e

" Pipes the selected region to `jq` for formatting
vmap <silent> <leader>jq :!cat\|jq . <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline=%<\ %{mode()}\ \|\ %f%m
set statusline+=%{&paste?'\ \ \|\ PASTE\ ':'\ '}
set statusline+=%=\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}\ \|\ %l/%L\(%c\)\ 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors/colorscheme/etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" give the active window a blue background and white foreground statusline
" hi StatusLine ctermfg=15 ctermbg=32 guifg=#FFFFFF guibg=#005FAF gui=bold cterm=bold
" hi SignColumn ctermfg=255 ctermbg=15 guifg=#E4E4E4 guibg=#FFFFFF
