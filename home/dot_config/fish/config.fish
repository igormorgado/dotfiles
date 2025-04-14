fish_vi_key_bindings

bind -M default delete delete-char
bind -M insert delete delete-char
bind -M visual delete delete-char

# Base
set -U fish_color_normal                        white
set -U fish_color_command                       blue
set -U fish_color_keyword                       blue
set -U fish_color_param                         white
set -U fish_color_option                        cyan
set -U fish_color_comment                       white --italics --dim
set -U fish_color_error                         red --bold
set -U fish_color_escape                        magenta --bold
set -U fish_color_quote                         white --italics
set -U fish_color_operator                      yellow
set -U fish_color_redirection                   yellow
set -U fish_color_end                           brwhite
set -U fish_color_match                         --background=yellow

# Autosuggestions and History
set -U fish_color_autosuggestion                white --dim
set -U fish_color_user                          white --dim
set -U fish_color_host                          white --dim
set -U fish_color_host_remote                   white --bold
set -U fish_color_cwd                           brwhite
set -U fish_color_cwd_root                      red
set -U fish_color_status                        brred --bold

# Pager
set -U fish_pager_color_prefix                  brwhite --bold
set -U fish_pager_color_completion              white
set -U fish_pager_color_description             white
set -U fish_pager_color_selected_background     --background=brblack
set -U fish_pager_color_selected_completion     brwhite --bold
set -U fish_pager_color_selected_description    brwhite --bold

# Misc
set -U fish_color_valid_path                    cyan
set -U fish_color_search_match                  --background=bryellow --bold
set -U fish_color_history_current               --bold
set -U fish_color_selection                     --reverse
set -U fish_color_rightprompt                   white --italics --dim
set -U fish_color_prompt                        green
set -U fish_color_git                           blue

set -Ux EDITOR nvim
set -Ux GIT_EDITOR nvim
set SHELL /usr/bin/fish
set NMON vcmknt.
set LESS '-R'
set LESSOPEN '|~/.lessfilter %s'

set -gx uvenv_home "$HOME/.uvenv"

set MC_SKIN 'darktrial'
set XLA_FLAGS --xla_gpu_cuda_data_dir=/usr/lib/cuda

fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin

set -gx PYENV_ROOT $HOME/.pyenv

set -gx PAGER less
# set -gx MC_SKIN /home/igor/.config/mc/solarized.ini

if set -q DISPLAY
    if test -r ~/.Xresources
        xrdb ~/.Xresources
    end
end

if test -r ~/.dir_colors
    eval (dircolors -c $HOME/.dir_colors)
end

if command -q zoxide
  zoxide init fish | source
end
#
# initialize pyenv
if command -q pyenv
  pyenv init - | source
  status --is-interactive; and pyenv virtualenv-init - | source
end

if command -q uv
  uv generate-shell-completion fish | source
end

if command -q uvx
  uvx --generate-shell-completion fish | source
end

# Load base uvenv if it exists (check if no other env is already loaded
# if functions -q uvenv; and not set -q VIRTUAL_ENV; and test -d $uvenv_home/base
#   uvenv base
# end


# Aliases
alias cscp="cscope -k -b -c -R; rm -f cctree.out"

alias ackpy="ack --python"

alias sstart="sudo systemctl start"
alias sstop="sudo systemctl stop"
alias srestart="sudo systemctl restart"
alias sstatus="sudo systemctl status"

alias shutc="sudo shutdown -c"
alias tb="nc termbin.com 9999"
alias vimclean="vim -u NONE -U NONE -N"
alias gplog="git log --oneline --graph --decorate --all"
alias vimgit='vim $(git diff --name-only stage | grep -v development.ini)'

# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# All of our servers eth0 is connected to the Internets via vlan / router etc  ##
alias dnstop='dnstop -l 5 eth0'
alias vnstat='vnstat -i eth0'
alias iftop='iftop -i eth0'
alias tcpdump='tshark -i eth0'
alias tshark='tshark -i eth0'
alias ethtool='ethtool eth0'

# work on wlan0 by default #
# Only useful for laptop as all servers are without wireless interface
alias iwconfig='iwconfig wlan0'

alias iotop='iotop'

## pass options to free ##
alias meminfo='free -m -l -t'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps aux | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps aux | sort -nr -k 3 | head -10'

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# For environments with bad apt sources
if command -q apt-get
  alias apt-get='apt-get --force-yes -y'
end

# alias venv='source venv/bin/activate.fish'
# alias actv='source venv/bin/activate.fish'
# alias activate='source venv/bin/activate.fish'
alias gdb='gdb -q'

# Modern life
alias vim="nvim"
alias vi="nvim"
alias e="nvim"
alias ls="lsd"
alias top="btop"
alias chez="chezmoi edit --apply"

alias secure="cryfs /mnt/data/igor/Secure/ /home/igor/Secure/ && cd /home/igor/Secure"
alias usecure="cryfs-unmount /home/igor/Secure"

# Edit common configurations
if command -q chezmoi
    echo "chezmoi"
    set CONFEDITOR "chezmoi edit --apply"
else 
    echo "$EDITOR"
    set CONFEDITOR $EDITOR
end

alias ednvim="$CONFEDITOR ~/.config/nvim/init.lua" 
alias edkitty="$CONFEDITOR ~/.config/kitty/kitty.conf"
alias edvifm="$CONFEDITOR ~/.config/vifm/vifmrc"
alias edfish="$CONFEDITOR ~/.config/fish/config.fish"

# vim: ft=fish:
