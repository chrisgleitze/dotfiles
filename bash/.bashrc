if test -t 1; then
	exec zsh
fi
. "$HOME/.cargo/env"
. "/home/chris/.deno/env"

if [ -x "$HOME/.linuxbrew/bin/brew" ]; then
	eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
