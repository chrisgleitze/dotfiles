"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" JavaScript syntax
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'herringtondarkholme/yats.vim'

" Formatting
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install --frozen-lockfile --production',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()

"""""""""""""""""
" Basic Options "
"""""""""""""""""

" disable built-in stuff I don't use
let g:loaded_2html_plugin = 1
let g:loaded_gzip = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_rplugin = 1
let g:loaded_rrhelper = 1
let g:loaded_spec = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tohtml = 1
let g:loaded_tutor = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

set rtp^=~/.vim
set nocompatible
filetype plugin indent on
syntax on
syntax sync minlines=256 " for faster syntax highlighting
set encoding=UTF-8
set updatetime=100
set signcolumn=yes
set nu rnu " absolute and relative line numbers
set linebreak
set mouse=a
set history=1000 " how many entries in cmdline history are saved
set ignorecase incsearch hlsearch
set scrolloff=10
set termguicolors
set laststatus=2
set noswapfile
set nobackup
set undofile
set nocursorline nocursorcolumn
set guicursor=n-v-c-sm-a:block
colorscheme slate

" timeout on key codes, not on mappings
set notimeout ttimeout
set ttimeoutlen=10

" command-line completion
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum

if !isdirectory($HOME . "/.vim/undodir")
  call mkdir($HOME . "/.vim/undodir", "p", 0700)
endif
set undodir=$HOME/.vim/undodir

" autocmd to remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" statusline
set statusline=%<\ %{mode()}\ \|\ %f%m
set statusline+=%{&paste?'\ \ \|\ PASTE\ ':'\ '}
set statusline+=%=\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}\ \|\ %l/%L\(%c\)\

" add mapping for auto closing
imap "<tab> ""<Left>
imap '<tab> ''<Left>
imap (<tab> ()<Left>
imap [<tab> []<Left>
imap {<tab> {}<Left>
imap {<cr> {<CR>}<ESC>O
imap {;<cr> {<CR>};<ESC>O

"""""""""""
" Keymaps "
"""""""""""

" make sure there's no other mapping for <space> and set <space> as mapleader
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <esc> :nohls<cr><esc>

nnoremap <Leader>Q :wqa!<cr>
nnoremap <Leader>W :w<cr>
nnoremap <Leader>S :source<cr>
nnoremap <Leader>n :enew<cr>
nnoremap <Leader>DB :bdelete<cr>

" make Y behave like C and D - copy text until end of line
nmap <silent> Y yg_

" delete all trailing whitespaces
nmap <silent> <leader>tw :%s/\s\+$//<cr>:let @/=''<CR>``

" go to previous, next ... buffer
nnoremap <Leader>j :bprevious<cr>
nnoremap <Leader>k :bnext<cr>
nnoremap <Leader>h :bfirst<cr>
nnoremap <Leader>l :blast<cr>

" open buffer via buffer list
nnoremap <C-b> :ls<cr>:b<space>

" center scroll up and down
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" move line up and down with Ctrl-k/j
nnoremap <A-j> :m .+1<cr>==
nnoremap <A-k> :m .-2<cr>==
inoremap <C-j> <Esc>:m .+1<cr>==gi
inoremap <C-k> <Esc>:m .-2<cr>==gi
vnoremap <C-j> :m '>+1<cr>gv=gv
vnoremap <C-k> :m '<-2<cr>gv=gv

""""""""""""""""""
" Plugin Configs "
""""""""""""""""""

" netrw
let g:netrw_liststyle = 3

" fugitive.vim
nmap <leader>Gi :Git<cr>
nmap <leader>Gb :Git blame<cr>
nmap <leader>Gd :Git diff<cr>
nmap <leader>Gl :Git log<cr>
nmap <leader>Gs :Git show<cr>

" fzf.vim
" ENTER		open the file in the current window
" CTRL-x	open the file in a new horizontal split
" CTRL-v	open the file in a new vertical split
" CTRL-t	open the file in a new tab
set rtp+=~/.fzf " set runtime path for fzf
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['down,50%']

nnoremap <silent> <leader><leader> :GFiles<cr>
nnoremap <silent> <leader>F :Files<cr>
nnoremap <silent> <leader>L :Lines<cr>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>Ag :RG<CR>
nnoremap <silent> <leader>Rg :Rg<CR>
nnoremap <silent> <leader>RG :RG<CR>

" [f]ind in [c]urrent buffer
nnoremap <silent> <leader>fc :BLines<CR>

nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>

nnoremap <silent> <leader>gc :Commits<CR>
nnoremap <silent> <leader>gb :BCommits<CR>

" insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-l> <plug>(fzf-complete-line)

" path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" prettier
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
