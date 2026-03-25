#!/bin/bash
# dev-tmux.sh
# Launch a tmux session with phid and saas windows,
# each with a terminal (left) and claude code (right)

SESSION="dev"

# Kill existing session if present
tmux has-session -t $SESSION 2>/dev/null && tmux kill-session -t $SESSION

# --- Window 1: phid ---
tmux new-session -d -s $SESSION -n phid -c /Users/carlos/code/phidippus

# Split vertically (left/right)
tmux split-window -h -t $SESSION:phid -c /Users/carlos/code/phidippus

# Right pane: launch claude code
tmux send-keys -t $SESSION:phid.1 'claude' C-m

# Select left pane (terminal)
tmux select-pane -t $SESSION:phid.0

# --- Window 2: saas ---
tmux new-window -t $SESSION -n saas -c /Users/carlos/code/rl2

# Split vertically (left/right)
tmux split-window -h -t $SESSION:saas -c /Users/carlos/code/rl2

# Right pane: launch claude code
tmux send-keys -t $SESSION:saas.1 'claude' C-m

# Select left pane (terminal)
tmux select-pane -t $SESSION:saas.0

# Start on the phid window
tmux select-window -t $SESSION:phid

# Attach
tmux attach -t $SESSION
