#!/bin/bash

# Use fzf to select a directory starting from the current directory
SELECTED_DIR=$(fd --type d --hidden --follow --exclude node_modules --exclude .git . | fzf --reverse --prompt="Select directory: ")

# Exit if nothing is selected
[ -z "$SELECTED_DIR" ] && exit 1

# Canonicalize the path and get its basename for tmux session
DIR_PATH=$(realpath "$SELECTED_DIR")
SESSION_NAME=$(basename "$DIR_PATH")

# Get current session name if inside tmux
CURRENT_SESSION=""
if [ -n "$TMUX" ]; then
  CURRENT_SESSION=$(tmux display-message -p '#S')
fi

# Check if tmux session exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? -eq 0 ]; then
  # Session exists
  if [ "$CURRENT_SESSION" = "$SESSION_NAME" ]; then
    # We're already in the session
    tmux attach -t "$SESSION_NAME"
  else
    # Switch to the session (either from outside tmux, or from a different session)
    if [ -n "$TMUX" ]; then
      tmux switch-client -t "$SESSION_NAME"
    else
      tmux attach -t "$SESSION_NAME"
    fi
  fi
else
  # New session, editor window & nvim
  tmux new-session -d -s "$SESSION_NAME" -c "$DIR_PATH" -n editor

  # Split editor window: left (80%) Neovim, right (20%) shell
  tmux send-keys -t "$SESSION_NAME:1.1" 'nvim' C-m
  tmux split-window -h -p 20 -t "$SESSION_NAME:1" -c "$DIR_PATH"

  # Create a second window as pure shell
  tmux new-window -t "$SESSION_NAME:2" -n shell -c "$DIR_PATH"

  # Return focus to the editor pane
  tmux select-pane -t "$SESSION_NAME:1.1"
  tmux select-window -t "$SESSION_NAME:1"

  # Attach to the new session
  tmux attach -t "$SESSION_NAME"
f