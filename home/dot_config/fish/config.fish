# set -g fish_trace 1
# set -l DEBUG 1
set -q DEBUG; and echo -n starting; and time_since_last

fish_vi_key_bindings
bind -M default delete delete-char
bind -M insert delete delete-char
bind -M visual delete delete-char
set -q DEBUG; and echo -n bindings; and time_since_last


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

set -q DEBUG; and echo -n theme; and time_since_last

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

if test -d /opt/homebrew/bin
    fish_add_path /opt/homebrew/bin
end
set -q DEBUG; and echo -n paths; and time_since_last

set -l HOMEBREW_ROOT /opt/homebrew
if test -d $HOMEBREW_ROOT
  fish_add_path $HOMEBREW_ROOT/bin
  $HOMEBREW_ROOT/bin/brew shellenv | source
end
set -q DEBUG; and echo -n homebrew; and time_since_last

set -l BASHER_ROOT $HOME/.basher
if test -d $BASHER_ROOT
  set basher $BASHER_ROOT/bin
  fish_add_path $basher
  status --is-interactive; and . (basher init - fish | psub)
end
set -q DEBUG; and echo -n basher; and time_since_last

# The next line updates PATH for the Google Cloud SDK.
set -l GOOGLE_SDK_PATH '/opt/google-cloud-sdk/path.fish.inc'
if test -f $GOOGLE_SDK_PATH
    source $GOOGLE_SDK_PATH
end
set -q DEBUG; and echo -n google_sdk; and time_since_last

# Verify if need to login at google
set -l delay_time 43200  # 12h
if      status is-interactive;
    and status is-login;
    and functions -q google_login;
    and should_run_google_login $delay_time
    google_login
end
set -q DEBUG; and echo -n google_login; and time_since_last

set -l PYENV_ROOT ~/.pyenv
if test -d $PYENV_ROOT
  fish_add_path $PYENV_ROOT/bin
  if command -q pyenv
    pyenv init - | source
    pyenv virtualenv-init - | source
  end
end
set -q DEBUG; and echo -n pyenv; and time_since_last

set -gx uvenv_home "$HOME/.uvenv"

set NMON vcmknt.
set LESS '-R'
set LESSOPEN '|~/.lessfilter %s'
set -gx PAGER less
set MC_SKIN 'darktrial'

if test -d /usr/lib/cuda
    set XLA_FLAGS --xla_gpu_cuda_data_dir=/usr/lib/cuda
end

if command -q nvim
    set -Ux EDITOR nvim
    set -Ux GIT_EDITOR nvim
else if command -q vim
    set -Ux EDITOR vim
    set -Ux GIT_EDITOR vim
end
set -q DEBUG; and echo -n settings; and time_since_last


if set -q DISPLAY; and test -r ~/.Xresources; and command -q xrdb
    xrdb ~/.Xresources 2>/dev/null
end
set -q DEBUG; and echo -n xrdb; and time_since_last

if test -r ~/.dir_colors; and command -q dircolors
    eval (dircolors -c $HOME/.dir_colors)
end
set -q DEBUG; and echo -n dircolor; and time_since_last

if command -q zoxide
  zoxide init fish | source
end
set -q DEBUG; and echo -n zoxide; and time_since_last

if command -q uv
  uv generate-shell-completion fish | source
end
set -q DEBUG; and echo -n uv; and time_since_last

if command -q uvx
  uvx --generate-shell-completion fish | source
end
set -q DEBUG; and echo -n uvx; and time_since_last

# Load base uvenv if it exists (check if no other env is already loaded
# if functions -q uvenv; and not set -q VIRTUAL_ENV; and test -d $uvenv_home/base
#   uvenv base
# end


########################################
# Aliases
########################################

# Base aliases
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# alias venv='source venv/bin/activate.fish'
# alias actv='source venv/bin/activate.fish'
# alias activate='source venv/bin/activate.fish'

# Linux only (commands that are based on Gnu Utils)
if test (uname) = "Linux"
    alias rm='rm -I --preserve-root'
    alias sstart="sudo systemctl start"
    alias sstop="sudo systemctl stop"
    alias srestart="sudo systemctl restart"
    alias sstatus="sudo systemctl status"
    alias shutc="sudo shutdown -c"
    alias meminfo='free -m -l -t'
    ## get top process eating memory
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps aux | sort -nr -k 4 | head -10'
    
    # get top process eating cpu ##
    alias pscpu='ps auxf | sort -nr -k 3'
    alias pscpu10='ps aux | sort -nr -k 3 | head -10'

    # get GPU ram on desktop / laptop##
    if test -f /var/log/Xorg.0.log
        alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
    end

end

# Vim
alias vimclean="vim -u NONE -U NONE -N"
alias vimgit='vim $(git diff --name-only stage | grep -v development.ini)'

# Git
alias gplog="git log --oneline --graph --decorate --all"

# Chezmoi
if command -q chezmoi
    alias chez="chezmoi edit --apply"
    set CONFEDITOR "chezmoi edit --apply"
else 
    set CONFEDITOR $EDITOR
end

if command -q chezmoi
    if command -q nvim
        alias ednvim="$CONFEDITOR ~/.config/nvim/init.lua" 
    end
    if command -q kitty
        alias edkitty="$CONFEDITOR ~/.config/kitty/kitty.conf"
    end
    if command -q vifm
        alias edvifm="$CONFEDITOR ~/.config/vifm/vifmrc"
    end
    if command -q fish
        alias edfish="$CONFEDITOR ~/.config/fish/config.fish"
    end
    if command -q vim
        alias edvim="$CONFEDITOR ~/.vim/vimrc"
    end
end


# Modern life
if command -q nvim
    alias vim="nvim"
    alias vi="nvim"
    alias e="nvim"
end

if command -q lsd
    alias ls="lsd"
end

if command -q btop
    alias top="btop"
end


# Rare command a based aliaes

if command -q cscope
    alias cscp="cscope -k -b -c -R; rm -f cctree.out"
end

if command -q ack
    alias ackpy="ack --python"
end

# For environments with bad apt sources
if command -q apt-get
  alias apt-get='apt-get --force-yes -y'
end

alias gdb='gdb -q'

if command -q cryfs
    alias secure="cryfs /mnt/data/igor/Secure/ /home/igor/Secure/ && cd /home/igor/Secure"
    alias usecure="cryfs-unmount /home/igor/Secure"
end

# Custom env for cloudwalk/macosx
alias tyrell="pyenv activate tyrell_venv; cd $HOME/repos/"
alias vols="cd /Volumes"
alias sec="cd /Volumes/Secure"
alias msec="hdiutil attach ~/secure.dmg"
alias jobsync="unison -auto -batch -confirmbigdel=false ssh://lab//home/jupyter/jobs $HOME/jobs"
alias k="kubectl"
alias todo="cat -p ~/TODO.txt"
alias etodo="e ~/TODO.txt"

set -q DEBUG; and echo -n aliases; and time_since_last

# vim: ft=fish:
