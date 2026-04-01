#!/bin/bash
# tmux-help.sh
# Quick reference for tmux (prefix is Ctrl+a)

cat <<'EOF'
tmux survival guide (prefix = Ctrl+a)
======================================

SESSIONS
  tmux new -s name          Create new session
  tmux attach -t name       Reattach to session
  tmux ls                   List sessions
  prefix d                  Detach (session keeps running)
  prefix $                  Rename session

WINDOWS (tabs)
  prefix c                  New window
  prefix n / p              Next / previous window
  prefix ,                  Rename window
  prefix &                  Close window

PANES
  prefix |                  Split left/right
  prefix -                  Split top/bottom
  Alt+Arrow                 Move between panes (no prefix needed)
  prefix z                  Zoom pane (toggle fullscreen)
  exit / Ctrl+d             Close pane

MOUSE
  Click pane                Select pane
  Drag border               Resize pane
  Click window name         Switch window
  Scroll                    Scroll history

iTERM2 INTEGRATION
  tmux -CC new -s name      Start with native iTerm2 tabs/splits
  tmux -CC attach -t name   Reattach with native iTerm2 tabs/splits
  (use Cmd+D, Cmd+T, Cmd+W as usual)
EOF
