#!/bin/bash
# k8s-tmux.sh
# Launch a tmux session for Kubernetes dev with pre-split panes

SESSION="k8s"

# Start a new detached session
tmux new-session -d -s $SESSION -n dev

# Pane 0: monitor pods
tmux send-keys -t $SESSION:0 'kubectl get pods -w' C-m

# Split horizontally: Pane 1 for commands
tmux split-window -h -t $SESSION:0
tmux send-keys -t $SESSION:0.1 'echo "Shell for ad-hoc commands"' C-m

# Split vertically on Pane 1: Pane 2 for logs/monitoring
tmux split-window -v -t $SESSION:0.1
tmux send-keys -t $SESSION:0.2 'echo "Optional monitoring/logs"' C-m

# Select first pane
tmux select-pane -t $SESSION:0.0

# Attach session
tmux attach -t $SESSION
