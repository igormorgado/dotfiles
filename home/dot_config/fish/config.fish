fish_vi_key_bindings
bind -M default delete delete-char
bind -M insert delete delete-char
bind -M visual delete delete-char
set -q DEBUG; and echo -n "Bindings "; and time_since_last

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
set -q DEBUG; and echo -n "Paths "; and time_since_last

if command -q nvim
    set -Ux EDITOR nvim
    set -Ux GIT_EDITOR nvim
else if command -q vim
    set -Ux EDITOR vim
    set -Ux GIT_EDITOR vim
end

set -Ux NMON vcmknt.
set -Ux LESS '-R'
set -Ux LESSOPEN '|~/.lessfilter %s'
set -Ux PAGER less
set -Ux MC_SKIN 'darktrial'

set -l CUDA_DATA_DIR /usr/lib/cuda
if test -d $CUDA_DATA_DIR
    set -Ux XLA_FLAGS --xla_gpu_cuda_data_dir=$CUDA_DATA_DIR
end
set -q DEBUG; and echo -n "Settings "; and time_since_last

# vim: ft=fish:
