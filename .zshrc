# user binaries
export PATH="$HOME/bin:$PATH"

[ -r "$HOME/.deno/env" ] && . "$HOME/.deno/env"

export PATH="$HOME/.local/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_DIR/versions/node/v22.22.3/bin:$PATH"

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt append_history inc_append_history extended_history hist_ignore_dups
[[ -r "$HISTFILE" ]] && fc -R "$HISTFILE"

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# start keychain only when an SSH-backed command actually needs it
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

# zsh
autoload -Uz compinit
compinit -C
setopt prompt_subst
_git_prompt_info() {
	local lines branch dirty
	lines=("${(@f)$(command git status --porcelain=v1 -b 2>/dev/null)}") || return
	[[ $lines[1] == "## "* ]] || return
	branch=${lines[1]#\#\# }
	branch=${branch%%...*}
	branch=${branch%% \[*}
	(( $#lines > 1 )) && dirty=' %F{yellow}✗%f'
	print -r -- " %F{cyan}git:(%F{red}${branch}%F{cyan})%f$dirty"
}
PROMPT='%(?.%F{green}.%F{red})➜ %F{cyan}%c%f$(_git_prompt_info) '
[ -r "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ] &&
	source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# suppress the "%" end-of-line marker
# tmux-resurrect leaves it visible at the top of restored panes
export PROMPT_EOL_MARK=""

# load nvm only when the nvm command is used
# node/npm are already on PATH
nvm() {
	unset -f nvm
	source "$NVM_DIR/nvm.sh"
	nvm "$@"
}

# fzf
# source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--height 80% --border --layout=reverse --info=hidden --color=fg:#f8f8f2,bg:#0e1419,hl:#e11299,fg+:#f8f8f2,bg+:#44475a,hl+:#e11299,info:#f1fa8c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#a4ffff,header:#6272a4 \
--cycle --pointer=▎ \
--marker=▎ \
--bind=alt-s:toggle"
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target,.venv,dist,build,.next --preview 'batcat --style=numbers --color=always --line-range :300 {}'"
export FZF_CTRL_R_OPTS="--no-preview --with-nth 2.."
export FZF_ALT_C_OPTS="--tmux 90% --border --preview 'tree -C {}'"

# editor
export EDITOR="$HOME/.local/bin/nvim"
export VISUAL="$EDITOR"

# aliases
alias ffv='vim $(fzf)'
alias ffn='nvim $(fzf)'

# bash scripts that integrate ripgrep into fzf
# then open file in vim or neovim
rfv() { "$HOME/.local/scripts/rfv.sh" "$@"; }
rfn() { "$HOME/.local/scripts/rfn.sh" "$@"; }

# ranger
alias r='ranger'

# alias for findfd
alias fd='fdfind'

# cd via fzf only from current directory
cdf() {
	local dir
	dir=$(fdfind --type d --exclude .git --exclude node_modules --exclude target --exclude .venv --exclude dist --exclude build --exclude .next . | fzf --no-preview) &&
		cd "$dir"
}

# cd via fzf from home directory, cdfa: cd find all
cdfa() {
	local dir
	dir=$(cd "$HOME" && fdfind --type d --exclude .git --exclude node_modules --exclude target --exclude .venv --exclude dist --exclude build --exclude .next . | fzf --no-preview) &&
		cd "$HOME/$dir"
}

# cd via fzf from home directory, incl. dotfiles
cdfd() {
	local dir
	dir=$(cd "$HOME" && fdfind --type d --hidden --exclude .git --exclude node_modules --exclude target --exclude .venv --exclude dist --exclude build --exclude .next . | fzf --no-preview) &&
		cd "$HOME/$dir"
}

# cd
alias cdn='cd $HOME/.config/nvim'
alias cdp='cd $HOME/projects'
alias cdd='cd $HOME/projects/diss'
alias cdN='cd $HOME/projects/notes'
alias cdv='cd $HOME/.vim'
alias ..='cd ..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias x='exit'

alias srr='sudo rm -rf'
alias bat='batcat'
alias c='clear'
alias grep='grep --color=auto'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias la='ls -A'
alias lr='ls -R'
alias lg='lazygit'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# git aliases
# alias gb='git branch'
alias gd='git diff'
alias gl='git log'
alias gs='git status'
alias gre='git restore .'
# alias ga='git add .'
# alias gaa='git add --all'
# alias gc='git commit'
# alias gcc='git commit -m "xxx"'
alias gco='git checkout'
alias gpl='git pull'
alias gpu='git push'

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
if [[ -t 1 ]]; then
	bindkey -s ^f "source ~/.local/scripts/tmux-sessionizer.sh\n"
fi
# bindkey -s ^F "source ~/.local/scripts/tmux-sessionizer.sh\n"

# load fzf keybindings/completion only in interactive terminals
if [[ -t 1 ]]; then
	path+=("$HOME/.fzf/bin")
	[ -r "$HOME/.fzf/shell/completion.zsh" ] && source "$HOME/.fzf/shell/completion.zsh"
	[ -r "$HOME/.fzf/shell/key-bindings.zsh" ] && source "$HOME/.fzf/shell/key-bindings.zsh"
fi

# keep command lookup lean after all shell integrations have touched PATH
typeset -U path PATH

# must be last
[ -r "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] &&
	source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
