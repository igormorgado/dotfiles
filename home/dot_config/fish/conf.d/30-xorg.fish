if set -q DISPLAY; and test -r ~/.Xresources; and command -q xrdb
    xrdb ~/.Xresources 2>/dev/null
end
set -q DEBUG; and echo -n xrdb; and time_since_last


