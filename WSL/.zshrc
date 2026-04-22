DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
ZSH_DISABLE_COMPFIX="true"

# Local wrappers speed up Oh My Zsh completion initialization.
fpath=("$HOME/.zsh/functions" $fpath)

# set tmux executable to path
export PATH="/home/chris/bin:$PATH"
export PATH="/usr/bin/tmux:$PATH"

. "/home/chris/.deno/env"

export PATH="$PATH:/home/chris/.local/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Start keychain only when an SSH-backed command actually needs it.
_ensure_ssh_key() {
	if [[ -z "$SSH_AUTH_SOCK" || ! -S "$SSH_AUTH_SOCK" ]]; then
		eval "$(keychain --quiet --eval --agents ssh id_ed25519)"
	fi
}

ssh() { _ensure_ssh_key; command ssh "$@"; }
scp() { _ensure_ssh_key; command scp "$@"; }
sftp() { _ensure_ssh_key; command sftp "$@"; }
git() {
	case "$1" in
		clone|fetch|pull|push|submodule) _ensure_ssh_key ;;
	esac
	command git "$@"
}

# Oh My ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting # needs to be last
)
source "$ZSH/oh-my-zsh.sh"

# Load nvm on first use instead of during every shell startup.
_load_nvm() {
	unset -f nvm node npm npx yarn pnpm corepack
	[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

nvm() { _load_nvm; nvm "$@"; }
node() { _load_nvm; node "$@"; }
npm() { _load_nvm; npm "$@"; }
npx() { _load_nvm; npx "$@"; }
yarn() { _load_nvm; yarn "$@"; }
pnpm() { _load_nvm; pnpm "$@"; }
corepack() { _load_nvm; corepack "$@"; }

# FZF
# source <(fzf --zsh)
# export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --border --preview 'batcat --style=numbers --color=always {}' --bind=alt-s:toggle"
export FZF_DEFAULT_OPTS="--height 80% --border --layout=reverse --info=hidden --preview 'batcat --style=numbers --color=always {}' --color=fg:#f8f8f2,bg:#0e1419,hl:#e11299,fg+:#f8f8f2,bg+:#44475a,hl+:#e11299,info:#f1fa8c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#a4ffff,header:#6272a4 \
--cycle --pointer=▎ \
--marker=▎ \
--bind=alt-s:toggle"
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target"
export FZF_CTRL_R_OPTS="--no-preview --with-nth 2.."
export FZF_ALT_C_OPTS="--tmux 90% --border --preview 'tree -C {}'"

# ALIASES
alias nvim='/usr/local/bin/nvim-linux-x86_64/bin/nvim'
alias ffv='vim $(fzf)'
alias ffn='nvim $(fzf)'

# bash script that integrates ripgrep into fzf
alias rfv='/home/chris/.local/scripts/rfv.sh'

# ranger
alias r="pipx run --spec ranger-fm ranger"

# alias for findfd
alias fd='fdfind'

# cd via fzf only from current directory
alias cdf='cd $(find * -type d | fzf --no-preview)'

# cd via fzf from home directory, cdfa: cd find all
alias cdfa='cd ~ && cd $(find * -type d | fzf --no-preview)'

# cd via fzf from home directory, cdfd: cd find all incl. dotfiles
alias cdfd='cd ~ && cd $(find . -type d -print | fzf --no-preview)'

# cd
alias cdn='cd $HOME/.config/nvim'
alias cdp='cd $HOME/projects'
alias cdv='cd $HOME/.vim'
alias ..='cd ..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias x='exit'

alias srr='sudo rm -rf'
alias bat='batcat'
alias c='clear'
alias ll='ls -alF'
alias ls='ls --color=auto'
# alias la='ls -A'
# alias lr='ls -R'
alias lg='lazygit'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# git aliases
# alias gb='git branch'
alias gl='git log'
alias gs='git status'
alias gre='git restore .'
# alias ga='git add .'
# alias gaa='git add --all'
# alias gc='git commit'
# alias gcc='git commit -m "xxx"'
alias gco='git checkout'
alias gpl='git pull'
# alias gpu='git push'

# git push
alias push='_ensure_ssh_key && ~/.local/scripts/git-push.sh'
# git push fast
alias pushf='_ensure_ssh_key && ~/.local/scripts/git-push-fast.sh'

# show only commit number and message
alias glo='git log --pretty=oneline --graph --abbrev-commit'

## git aliases to investigate a code base
## credit to Ally Piechowski:
## https://piechowski.io/post/git-commands-before-reading-code/
# 20 most [c]hanged files in the last year
alias gc20='git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20'

# [s]hort[l]og to see every contributor ranked by commit count
# add e.g.:  --since="6 months ago
alias gsl='git shortlog -sn --no-merges'

# commit count by month for entire [his]tory of repo
alias ghis='git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c'

# 20 most changed files, filtered by [b]ug related keywords
alias gb20='git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20'

# list of reverts, [hot]fixes etc. commits in the last year
alias ghot='git log --oneline --since="1 year ago" | grep -iE "revert|hotfix|emergency|rollback"'

##################################

# keybind to start tmux-sessionizer
bindkey -s ^f "source ~/.local/scripts/tmux-sessionizer.sh\n"
# bindkey -s ^F "source ~/.local/scripts/tmux-sessionizer.sh\n"

# bun completions
[ -s "/home/chris/.bun/_bun" ] && source "/home/chris/.bun/_bun"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
