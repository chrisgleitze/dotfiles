call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" JavaScript syntax
Plug 'yuezk/vim-js'
" Plug 'maxmellon/vim-jsx-pretty'
Plug 'herringtondarkholme/yats.vim'

" JavaScript formatting
Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install --frozen-lockfile --production',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype plugin indent on
syntax on
syntax sync minlines=256
set nu
set rnu
set linebreak
set mouse=a
set ignorecase
set incsearch
set hlsearch
set scrolloff=10
set termguicolors
set laststatus=2
set noswapfile
set nobackup
set undofile
set guicursor=n-v-c-sm-a:block
colorscheme slate

if !isdirectory($HOME . "/.vim/undodir")
  call mkdir($HOME . "/.vim/undodir", "p", 0700)
endif
set undodir=$HOME/.vim/undodir

" Statusline
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make sure there's no other mapping for <space> and set <space> as mapleader
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <esc> :noh<cr><esc>

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

" buffer list
nnoremap <C-b> :ls<cr>:b<Space>

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" netrw
let g:netrw_liststyle = 3

" fugitive.vim
nmap <leader>Gi :Git<cr>
nmap <leader>gb :Git blame<cr>
nmap <leader>gm :Gsplit main:%<cr>

" fzf.vim
" ENTER		open the file in the current window
" CTRL-x	open the file in a new horizontal split
" CTRL-v	open the file in a new vertical split
" CTRL-t	open the file in a new tab
set rtp+=~/.fzf " set runtime path for fzf
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

nnoremap <leader><leader> :Files<cr>

nnoremap <silent> <leader><leader> :Files<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
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
