""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Formatting
Plug 'prettier/vim-prettier', {
	\ 'do': 'zsh -ic ''yarn install --frozen-lockfile --production''',
	\ 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()

"""""""""""""""""
" Basic Options "
"""""""""""""""""

filetype plugin indent on
syntax on
syntax sync minlines=256 " for faster syntax highlighting
set clipboard=
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
set nobackup
set writebackup
set backupskip=/tmp/*,/private/tmp/*
set undofile
set nocursorline nocursorcolumn
set guicursor=n-v-c-sm-a:block
set diffopt+=linematch:60
colorscheme slate

packadd comment
let g:hlput_enable = 1
packadd hlyank

" timeout on key codes, not on mappings
set notimeout ttimeout
set ttimeoutlen=10

" command-line completion
set wildmenu
set wildmode=noselect:longest:full,full
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

" WSL/Windows clipboard, without Vim's flaky X11/+clipboard path.
" Use temp register z so normal registers and normal y/p stay Vim-internal.
function! s:PasteFromWindowsClipboard() abort
  let @z = system(['powershell.exe', '-NoLogo', '-NoProfile', '-Command', '[Console]::Out.Write((Get-Clipboard -Raw).ToString().Replace("`r", ""))'])
  normal! "zp
endfunction

" Visual selection -> Windows clipboard.
xnoremap <silent> <leader>y "zy:<C-u>call system(['clip.exe'], @z)<CR>
" Cursor to last non-blank char of line -> Windows clipboard, like Y/yg_.
nnoremap <silent> <leader>Y "zyg_:call system(['clip.exe'], @z)<CR>
" Windows clipboard -> temp register z -> paste after cursor.
nnoremap <silent> <leader>p :<C-u>call <SID>PasteFromWindowsClipboard()<CR>

nnoremap <leader>QQ :wqa!<cr>
nnoremap <leader>S :source $MYVIMRC<cr>
nnoremap <leader>n :enew<cr>
nnoremap <leader>DB :bdelete<cr>

" keymaps to save file
nnoremap <silent> <C-s> :silent update<CR>
inoremap <silent> <C-s> <Esc>:silent update<CR>
xnoremap <silent> <C-s> :<C-u>silent update<CR>

" jump to the end of the line in insert/command mode
inoremap <C-l> <C-o>A
cnoremap <C-l> <End>

" make Y copy until last non-blank character of the line
nnoremap <silent> Y yg_

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

" center search results
nnoremap n nzzzv
nnoremap N Nzzzv

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

" vim-gitgutter
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '▎'

nmap <silent> gs[ <Plug>(GitGutterPrevHunk)
nmap <silent> gs] <Plug>(GitGutterNextHunk)
nmap <silent> <leader>gsh <Plug>(GitGutterPreviewHunk)
nmap <silent> <leader>gsi <Plug>(GitGutterPreviewHunk)
nmap <silent> <leader>gss <Plug>(GitGutterStageHunk)
xmap <silent> <leader>gss <Plug>(GitGutterStageHunk)
nmap <silent> <leader>gsr <Plug>(GitGutterUndoHunk)

" fugitive:
nnoremap <leader>Gi :Git <cr>
nnoremap <leader>Gl :Git log<cr>
nnoremap <leader>Gs :Git show<cr>
nnoremap <leader>Gb :Git blame<cr>
nnoremap <leader>Gd :Git diff<cr>
nnoremap <leader>Gw :Gwrite<cr>
nnoremap <leader>Gc :G commit<cr>
nnoremap <leader>Gp :Git push<cr>
" [R]eset buffer, Git [b]lame whole buffer, Git blame [l]ine
nnoremap <silent> <leader>gsR :Gread<CR>
nnoremap <silent> <leader>gsb :Git blame<CR>
nnoremap <silent> <leader>gsl :execute line('.') . ',' . line('.') . 'Git blame'<CR>


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
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.yml,*.html Prettier
augroup END
