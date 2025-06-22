
#!/bin/bash

# Get the current directory name to use as the session name
SESSION_NAME="${PWD##*/}"

# Check if the session already exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? -eq 0 ]; then
  # Session exists, just attach
  tmux attach -t "$SESSION_NAME"
else
  # Session doesn't exist, create with two windows in this directory
  tmux new-session -d -s "$SESSION_NAME" -c "$PWD" -n editor
  tmux new-window -t "$SESSION_NAME:2" -n shell -c "$PWD"
  tmux new-window -t "$SESSION_NAME:3" -n shell2 -c "$PWD"
  tmux select-window -t "$SESSION_NAME:1"
  tmux attach -t "$SESSION_NAME"
fi
