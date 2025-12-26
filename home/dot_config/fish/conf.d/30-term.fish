if type -q dircolors
    if test -r $HOME/.dir_colors
        set -gx LS_COLORS (dircolors -c $HOME/.dir_colors | string replace 'setenv LS_COLORS ' '')
    else
        set -gx LS_COLORS (dircolors -c | string replace 'setenv LS_COLORS ' '')
    end
end

time_since_last "Term"

