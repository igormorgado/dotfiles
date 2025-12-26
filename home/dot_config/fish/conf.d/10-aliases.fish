# Base aliases
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Parenting changing perms on / #
# TODO: Make chezmoi template to not install --preserve-root at macosx
# alias chown='chown --preserve-root'
# alias chmod='chmod --preserve-root'
# alias chgrp='chgrp --preserve-root'

# alias venv='source venv/bin/activate.fish'
# alias actv='source venv/bin/activate.fish'
# alias activate='source venv/bin/activate.fish'

# Linux only (commands that are based on Gnu Utils)
if test (uname) = "Linux"
    alias rm='rm -I --preserve-root'
    command -q systemctl; and alias sstart="sudo systemctl start"
    command -q systemctl; and alias sstop="sudo systemctl stop"
    command -q systemctl; and alias srestart="sudo systemctl restart"
    command -q systemctl; and alias sstatus="sudo systemctl status"
    command -q shutdown; and alias shutc="sudo shutdown -c"
    command -q free; and alias meminfo='free -m -l -t'
    ## get top process eating memory
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps aux | sort -nr -k 4 | head -10'

    # get top process eating cpu ##
    alias pscpu='ps auxf | sort -nr -k 3'
    alias pscpu10='ps aux | sort -nr -k 3 | head -10'

    # get GPU ram on desktop / laptop##
    test -f /var/log/Xorg.0.log; and alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

end

# Coreutils on macos
command -q gdircolors; and alias dircolors="gdircolors"

# Vim
command -q vim; and alias vimclean="vim -u NONE -U NONE -N"
command -q vim; and command -q git; and alias vimgit='vim $(git diff --name-only stage | grep -v development.ini)'

# Git
command -q git; and alias gplog="git log --oneline --graph --decorate --all"

# Chezmoi
if command -q chezmoi
    alias chez="chezmoi edit --apply"
    set CONFEDITOR "chezmoi edit --apply"
else
    set CONFEDITOR $EDITOR
end

if command -q chezmoi
    command -q nvim; and alias ednvim="$CONFEDITOR ~/.config/nvim/init.lua"
    command -q kitty; and alias edkitty="$CONFEDITOR ~/.config/kitty/kitty.conf"
    command -q vifm; and alias edvifm="$CONFEDITOR ~/.config/vifm/vifmrc"
    command -q fish; and alias edfish="$CONFEDITOR ~/.config/fish/config.fish"
    command -q vim; and alias edvim="$CONFEDITOR ~/.vim/vimrc"
end

# Modern life
if command -q nvim
    alias vim="nvim"
    alias vi="nvim"
    alias e="nvim"
end

command -q lsd; and alias ls="lsd"
command -q btop; and alias top="btop"


# Rare command a based aliaes

command -q cscope; and alias cscp="cscope -k -b -c -R; rm -f cctree.out"
command -q ack; and alias ackpy="ack --python"

# For environments with bad apt sources
alias apt-get='apt-get --force-yes -y'

command -q gdb; and alias gdb='gdb -q'

if command -q cryfs
    alias secure="cryfs /mnt/data/igor/Secure/ /home/igor/Secure/ && cd /home/igor/Secure"
    alias usecure="cryfs-unmount /home/igor/Secure"
end

# Custom env for cloudwalk/macosx
command -q pyenv; and alias tyrell="pyenv activate tyrell_venv; cd $HOME/repos/"
alias vols="cd /Volumes"
alias sec="cd /Volumes/Secure"
alias msec="hdiutil attach ~/secure.dmg"
command -q unison; and alias jobsync="unison -auto -batch -confirmbigdel=false ssh://lab//home/jupyter/jobs $HOME/jobs"
command -q kubectl; and alias k="kubectl"
alias todo="cat -p ~/TODO.txt"
alias etodo="e ~/TODO.txt"

time_since_last "Aliases"
