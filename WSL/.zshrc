# compinit is zsh completion system; improve zsh startup time:
# rebuilding compinit on every startup is unnecessary;
# rebuild if cached compinit is not from today, use cached if it's from today
autoload compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# load SSH ID
eval `keychain --eval --agents ssh id_ed25519`

# Oh My ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting # needs to be last
)
source "$ZSH/oh-my-zsh.sh"
source "$HOME/.fzf/shell/completion.zsh"
source "$HOME/.fzf/shell/key-bindings.zsh"

# set tmux executable to path
export PATH="/home/chris/bin:$PATH"
export PATH="/usr/bin/tmux:$PATH"

source ~/.nvm/nvm.sh

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# FZF
# source <(fzf --zsh)
export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --border --preview 'batcat --style=numbers --color=always {}'"

# ALIASES
alias nvim='/usr/local/bin/nvim-linux-x86_64/bin/nvim'
alias ffv='vim $(fzf)'
alias ffn='nvim $(fzf)'

# ranger
alias r="pipx run --spec ranger-fm ranger"

# alias for findfd
alias fd='fdfind'

# cd via fzf only from current directory
alias cdf='cd $(find * -type d | fzf)'

# cd via fzf from home directory, cdfa: cd find all
alias cdfa='cd ~ && cd $(find * -type d | fzf)'

# cd via fzf from home directory, cdfd: cd find all incl. dotfiles
alias cdfd='cd ~ && cd $(find . -type d -print | fzf)'

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
alias la='ls -A'
alias lr='ls -R'
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
# alias gco='git checkout'
alias gpl='git pull'
# alias gpu='git push'

# git push
alias push='~/.local/scripts/git-push.sh'
# git push fast
alias pushf='~/.local/scripts/git-push-fast.sh'

# keybind to start tmux-sessionizer
bindkey -s ^f "source ~/.local/scripts/tmux-sessionizer.sh\n"
# bindkey -s ^F "source ~/.local/scripts/tmux-sessionizer.sh\n"

. "/home/chris/.deno/env"

# Created by `pipx` on 2025-09-07 15:35:44
export PATH="$PATH:/home/chris/.local/bin"

# bun completions
[ -s "/home/chris/.bun/_bun" ] && source "/home/chris/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
