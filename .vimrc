""""""""""
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
Plug 'jiangmiao/auto-pairs'

" JavaScript syntax
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'herringtondarkholme/yats.vim'

" Formatting
Plug 'prettier/vim-prettier', {
	\ 'do': 'zsh -ic ''yarn install --frozen-lockfile --production''',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()

"""""""""""""""""
" Basic Options "
"""""""""""""""""

" disable built-in stuff I don't use
let g:loaded_2html_plugin = 1
let g:did_install_default_menus = 1
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

filetype plugin indent on
syntax on
syntax sync minlines=256 " for faster syntax highlighting
set clipboard=unnamedplus
set updatetime=100
set autoread
set signcolumn=yes
set nu rnu " absolute and relative line numbers
set linebreak
set mouse=a
set history=1000 " how many entries in cmdline history are saved
set hidden
set ignorecase incsearch hlsearch
set scrolloff=10
set scrolloffpad=1
set termguicolors
set laststatus=2
set noswapfile
set nobackup
set writebackup
set backupskip=/tmp/*,/private/tmp/*
set undofile
set nocursorline nocursorcolumn
set guicursor=n-v-c-sm-a:block
colorscheme slate

let g:hlput_enable = 1
packadd hlyank

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

" remove trailing whitespace on save
function! s:TrimTrailingWhitespace() abort
  if !&modifiable || &buftype !=# ''
    return
  endif

  let l:view = winsaveview()
  keepjumps keeppatterns silent! %s/\s\+$//e
  call winrestview(l:view)
endfunction

augroup vimrc_trim_trailing_whitespace
  autocmd!
  autocmd BufWritePre * call <SID>TrimTrailingWhitespace()
augroup END

" statusline
set statusline=%<\ %{mode()}\ \|\ %f%m
set statusline+=%{&paste?'\ \ \|\ PASTE\ ':'\ '}
set statusline+=%=\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}\ \|\ %l/%L\(%c\)\

"""""""""""
" Keymaps "
"""""""""""

" make sure there's no other mapping for <space> and set <space> as mapleader
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

nnoremap <leader>QQ :wqa!<cr>
nnoremap <C-s> :w<cr>
nnoremap <leader>S :source $MYVIMRC<cr>
nnoremap <leader>n :enew<cr>
nnoremap <leader>DB :bdelete<cr>

" make Y copy until last non-blank character of the line
nmap <silent> Y yg_

" delete all trailing whitespaces
nmap <silent> <leader>tw :%s/\s\+$//<cr>:let @/=''<CR>``

" go to previous, next ... buffer
nnoremap <leader>j :bprevious<cr>
nnoremap <leader>k :bnext<cr>
nnoremap <leader>h :bfirst<cr>
nnoremap <leader>l :blast<cr>

" open buffer via buffer list
nnoremap <C-b> :ls<cr>:b<space>

" center scroll up and down
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" move line up and down
" nnoremap <C-j> :m .+1<cr>==
" nnoremap <C-k> :m .-2<cr>==
inoremap <C-j> <esc>:m .+1<cr>==gi
inoremap <C-k> <esc>:m .-2<cr>==gi
vnoremap <C-j> :m '>+1<cr>gv=gv
vnoremap <C-k> :m '<-2<cr>gv=gv

""""""""""""""""""
" Plugin Configs "
""""""""""""""""""

" netrw
let g:netrw_liststyle = 3

" fugitive.vim
nnoremap <leader>Gi :Git <cr>
nnoremap <leader>Gl :Git log<cr>
nnoremap <leader>Gs :Git show<cr>
nnoremap <leader>Gb :Git blame<cr>
nnoremap <leader>Gd :Git diff<cr>
nnoremap <leader>Gw :Gwrite<cr>
nnoremap <leader>Gc :G commit<cr>
nnoremap <leader>Gp :Git push<cr>


" fzf.vim
" ENTER		open the file in the current window
" CTRL-v	open the file in a new vertical split
" CTRL-x	open the file in a new horizontal split
" CTRL-t	open the file in a new tab
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['down,50%']

nnoremap <silent> <leader><leader> :GFiles<cr>
nnoremap <silent> <leader>F :Files<cr>
nnoremap <silent> <leader>L :Lines<cr>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>Ag :Ag<CR>
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
augroup vimrc_prettier
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier
augroup END
