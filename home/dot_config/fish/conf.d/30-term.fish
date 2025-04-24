test -r $HOME/.dir_colors;
    and command -q dircolors; 
    and set -gx LS_COLORS (dircolors -c $HOME/.dir_colors | sed 's/setenv LS_COLORS //') 
    # and eval (dircolors -c $HOME/.dir_colors | sed 's/setenv/set -gx/')

set -q DEBUG; and echo -n "Term "; and time_since_last


