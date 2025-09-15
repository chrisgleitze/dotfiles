#!/usr/bin/env bash

session=$(find ~/projects ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)

session_name=$(basename "$session" | tr . _)

if ! tmux has-session -t "$session_name" 2>/dev/null; then
	tmux new-session -s "$session_name" -c "$session" -d
fi

tmux switch-client -t "$session_name"

# session=$(find ~/projects ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
# session_name=$(basename "$session" | tr . _)
#
# if ! tmux has-session -t "$session_name" 2>/dev/null; then
# 	tmux new-session -s "$session_name" -c "$session" -d
# fi
#
# tmux switch-client -t "$session_name"

######

# if [[ $# -eq 1 ]]; then
# 	selected=$1
# else
# 	selected=$(find ~/projects ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
# fi
#
# if [[ -z $selected ]]; then
# 	exit 0
# fi
#
# selected_name=$(basename "$selected" | tr . _)
# tmux_running=$(pgrep tmux)
#
# if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
# 	tmux new-session -s $selected_name -c $selected
# 	exit 0
# fi
#
# if ! tmux has-session -t=$selected_name 2>/dev/null; then
# 	tmux new-session -ds $selected_name -c $selected
# fi
#
# tmux switch-client -t $selected_name

######

# if [[ $# -eq 1 ]]; then
# 	selected=$1
# else
# 	selected=$(find ~/projects ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
# fi
#
# if [[ -z $selected ]]; then
# 	exit 0
# fi
#
# selected_name=$(basename "$selected" | tr . _)
# tmux_running=$(pgrep tmux)
# if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
# 	tmux new-session -s $selected_name -c $selected
# 	exit 0
# fi
#
# if ! tmux has-session -t $selected_name 2>/dev/null; then
# 	tmux new-session -ds $selected_name -c $selected
# fi
#
# if [[ -z $TMUX ]]; then
# 	tmux attach-session -t $selected_name
# else
# 	tmux switch-client -t $selected_name
# fi
