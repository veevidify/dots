cd $HOME

tmux new-session -d -s dev

tmux new-window -t dev

tmux split-window -h -t dev:0
tmux split-window -v -t dev:0.1

tmux split-window -h -t dev:1

tmux select-window -t dev:0.0
tmux resize-pane -t dev:0.0 -L 20
tmux resize-pane -t dev:0.1 -D 20

tmux a -t dev
