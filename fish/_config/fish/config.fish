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
set GIT_EDITOR vim
set SHELL /usr/bin/fish
set NMON vcmknt.

export XLA_FLAGS=--xla_gpu_cuda_data_dir=/usr/lib/cuda

fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin

set -gx PAGER less
# set -gx MC_SKIN /home/igor/.config/mc/solarized.ini
#
if set -q DISPLAY
    if test -r ~/.Xresources

        xrdb ~/.Xresources
    end
end

if test -r ~/.dir_colors
    eval (dircolors $HOME/.dir_colors)
end

# Aliases
alias cp='rsync --progress --recursive --archive'
