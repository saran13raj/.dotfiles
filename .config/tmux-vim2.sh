
#!/bin/bash

# Get the current directory name to use as the session name
SESSION_NAME="${PWD##*/}"

# Check if the session already exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? -eq 0 ]; then
  # Session exists, just attach
  tmux attach -t "$SESSION_NAME"
else
  # Create a new session, window 1: editor
  tmux new-session -d -s "$SESSION_NAME" -c "$PWD" -n editor

  # Split window 1 vertically (left 80% editor, right 20% shell)
  tmux send-keys -t "$SESSION_NAME:1.1" 'nvim' C-m
  tmux split-window -h -p 20 -t "$SESSION_NAME:1" -c "$PWD"

  # Window 2: shell
  tmux new-window -t "$SESSION_NAME:2" -n shell -c "$PWD"

  # Focus on the editor pane
  tmux select-pane -t "$SESSION_NAME:1.1"
  tmux select-window -t "$SESSION_NAME:1"

  # Attach to the session
  tmux attach -t "$SESSION_NAME"
fi
