if set -q DISPLAY; and test -r ~/.Xresources; and command -q xrdb
    xrdb ~/.Xresources 2>/dev/null
end
time_since_last "Xorg"


