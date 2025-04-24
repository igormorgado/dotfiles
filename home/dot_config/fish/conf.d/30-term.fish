if test -r ~/.dir_colors; and command -q dircolors
    eval (dircolors -c $HOME/.dir_colors | sed 's/setenv/set -g/')
end
set -q DEBUG; and echo -n "Dircolor "; and time_since_last


