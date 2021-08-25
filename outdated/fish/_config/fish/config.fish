xrdb ~/.Xresources

set -U fish_user_paths $HOME/bin $HOME/.local/bin $fish_user_paths
set -gx MC_SKIN /home/igor/.config/mc/solarized.ini
set SHELL /usr/bin/fish

fish_vi_key_bindings

function fish_greeting
  cbonsai -p
end

function fish_mode_prompt --description 'Displays the current mode'
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
      switch $fish_bind_mode
          case default
              set_color --bold brred
              echo N
          case insert
              set_color --bold brgreen
              echo I
          case replace_one
              set_color --bold brblue
              echo R
          case visual
              set_color --bold brpurple
              echo V
      end
      set_color normal
      printf " "
  end
end

set fish_color_normal white
set fish_color_command white
set fish_color_keyword white --bold
set fish_color_param white
set fish_color_quote white --italics
set fish_color_comment white --italics --dim
set fish_color_selection --reverse

set fish_color_user brblack
set fish_color_host brblack
set fish_color_host_remote --bold white
set fish_color_cwd brwhite
set fish_color_prompt brgreen
set fish_color_git blue

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    if test $COLUMNS -lt 100
        set -g fish_prompt_pwd_dir_length 1
    else
        set -g fish_prompt_pwd_dir_length 0
    end

    # User
    set_color $fish_color_user
    echo -n $USER
    set_color normal

    echo -n '@'

    # Host
    set_color $fish_color_host
    echo -n (prompt_hostname)
    set_color normal

    echo -n ':'

    # PWD
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal

    __terlar_git_prompt
    or fish_hg_prompt

    echo
    if not test $last_status -eq 0
        set_color $fish_color_error
        echo -n "😂[$last_status]"
    else
        set_color $fish_color_prompt
    end

    echo -n '➤ '
    # echo -n '〉'
    set_color normal
end

function fish_right_prompt -d "The right prompt"
    date '+%y/%m/%d %H:%M:%S'
end

if status --is-interactive
    # source $HOME/.config/fish/interactive.fish
    function fish_user_key_bindings
       bind \co 'clear; commandline -f repaint'
       bind --mode insert \co 'clear; commandline -f repaint'
       bind --sets-mode insert \co 'clear; commandline -f repaint'
    end
end

alias cp='rsync --progress --recursive --archive'
alias zeroad="pushd ~/src/0ad/;./binaries/system/pyrogenesis; popd"

