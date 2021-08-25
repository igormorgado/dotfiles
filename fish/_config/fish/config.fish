fish_vi_key_bindings

set fish_color_normal white
set fish_color_command white
set fish_color_keyword white --bold
set fish_color_param white
set fish_color_quote white --italics
set fish_color_comment white --italics --dim
set fish_color_selection --reverse

set fish_color_user white --dim
set fish_color_host white --dim
set fish_color_host_remote --bold white
set fish_color_cwd brwhite
set fish_color_prompt green
set fish_color_git blue

set EDITOR vim
set SHELL /usr/bin/fish

#set -U fish_user_paths $HOME/bin $HOME/.local/bin $fish_user_paths
# set -gx MC_SKIN /home/igor/.config/mc/solarized.ini

if test -r ~/.Xresources
    xrdb ~/.Xresources
end

# Aliases
alias cp='rsync --progress --recursive --archive'
