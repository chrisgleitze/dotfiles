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

# set tmux executable to path
# export PATH="/usr/bin/tmux"

# set tmux sessionizer to path
export PATH="/home/chris/bin:$PATH"

# OLD:
# export PATH="$PATH:/opt/nvim-linux64/bin"
# export PATH="$PATH:/.config/./nvim.appimage"
# alias nvim="~/.config/nvim.appimage"

# NOW: installed neovim 0.10 appimage, moved nvim.appimage to /usr/local/bin/nvim
# https://stackoverflow.com/questions/64463233/how-to-use-nvim-command-if-neovim-is-installed-using-appimage
# https://www.reddit.com/r/neovim/comments/eecbck/nvimappimage/

# eval `keychain --eval --agents ssh id_rsa`
eval `keychain --eval --agents ssh id_ed25519`

# source ~/.nvm/nvm.sh

function pv { fzf --preview='cat {}' }

# cd via fzf only from current directory
alias cdf='cd $(find * -type d | fzf)'

# cd via fzf from home directory, cdfa: cd find all
alias cdfa='cd ~ && cd $(find * -type d | fzf)'

# cd via fzf from home directory, cdfd: cd find all incl. dotfiles
alias cdfd='cd ~ && cd $(find . -type d -print | fzf)'

alias cdnvim='cd $HOME/.config/nvim'
alias cdproj='cd $HOME/projects'
alias bat='batcat'
alias c='clear'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias la='ls -A'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/.nvm/nvm.sh

# git aliases
alias gb='git branch'
alias gl='git log'
alias gs='git status'
alias ga='git add .'
alias gaa='git add --all'
alias gc='git commit'
alias gcc='git commit -m "xxx"'
alias gco='git checkout'
alias gpu='git push'
