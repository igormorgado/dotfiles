test -r $HOME/.dir_colors;
    and command -q dircolors; 
    and eval (dircolors -c $HOME/.dir_colors | sed 's/setenv/set -gx/')

set -q DEBUG; and echo -n "Term "; and time_since_last


