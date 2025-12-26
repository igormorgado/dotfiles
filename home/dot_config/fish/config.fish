fish_vi_key_bindings
bind -M default delete delete-char
bind -M insert delete delete-char
bind -M visual delete delete-char

set -q DEBUG; and time_since_last "Bindings"

# Ensure readenv autoload is available for PWD hook
if not functions -q readenv
    set -l __readenv_path "$HOME/.config/fish/functions/readenv.fish"
    test -f $__readenv_path; and source $__readenv_path
end

# First thing, add paths
if test -d $HOME/bin
    fish_add_path $HOME/bin
end

if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
end

if test -d /opt/nvim-macos/bin
  fish_add_path /opt/nvim-macos/bin
end
set -q DEBUG; and time_since_last "Paths"

if command -q nvim
    set -gx EDITOR nvim
    set -gx GIT_EDITOR nvim
else if command -q vim
    set -gx EDITOR vim
    set -gx GIT_EDITOR vim
end

set -gx npm_config_prefix "$HOME/.local"

set -gx NMON vcmknt.
set -gx LESS '-RXF'
set -gx LESSOPEN '|~/.lessfilter %s'
set -gx PAGER less
set -gx MC_SKIN 'darktrial'

set -l CUDA_DATA_DIR /usr/lib/cuda
if test -d $CUDA_DATA_DIR
    set -gx XLA_FLAGS --xla_gpu_cuda_data_dir=$CUDA_DATA_DIR
end



set -q DEBUG; and time_since_last "Settings"

# vim: ft=fish:
