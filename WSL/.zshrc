export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"
source "$HOME/.fzf/shell/completion.zsh"
source "$HOME/.fzf/shell/key-bindings.zsh"

export PATH="$PATH:/opt/nvim-linux64/bin"

eval `keychain --eval --agents ssh id_rsa`

source ~/.nvm/nvm.sh

function pv { fzf --preview='cat {}' }

alias bat='batcat'
alias c='clear'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias la='ls -A'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
