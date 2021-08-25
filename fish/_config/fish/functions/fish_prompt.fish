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
