function __dt_user --description 'Write username colored'
    if set -q $fish_color_user
        set_color $fish_color_user
    end
    echo -n $USER
    set_color normal
end


function __dt_color_host --description "Write host color. Different if remote"
    if set -q SSH; and set -q fish_color_host_remote
        echo $fish_color_host_remote
    else if set -q fish_color_host
        echo $fish_color_host
    else
        echo normal
    end
end


function __dt_host --description 'Write hostname colored'
    set -l host_color (__dt_color_host)
    set_color $host_color
    echo -n (prompt_hostname)
    set_color normal
end


function __dt_pwd --description 'Write pwd colored'
    # Set cwd color
    if set -q fish_color_cwd
        set_color $fish_color_cwd
    end

    # is it root?
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set_color $fish_color_cwd_root
        end
    end

    echo -n (prompt_pwd)
    set_color normal
end


function __dt_status --description 'Write colored status'
    if test (count $argv) -gt 0
        set -l last_status $argv[1]
    else
        set -l last_status 0
    end

    if test "$last_status" != "0"
        echo "LAST STATUS status [$last_status]"
        if set -q fish_color_error
            set_color $fish_color_error
        end
        echo -n "✘ $last_status"
    end
    set_color normal
end


function __dt_suffix --description 'Write the prompt'
    if test (count $argv) -gt 0
        set -l last_status $argv[1]
    else
        set -l last_status 0
    end

    # Decide if suffix is root or not
    if functions -q fish_is_root_user; and fish_is_root_user
        set -l suffix '#'
    else 
        set -l suffix '❯'
    end

    if set -q fish_color_prompt
        set_color $fish_color_prompt
    end

    if test "$last_status" != "0"; and set -q fish_color_error
        echo "LAST STATUS suffix [$last_status]"
        set_color $fish_color_error
    end

    echo -n "$suffix"
    set_color normal
end
 
function __dt_login --description 'Write the login information'
    echo -n -s (__dt_user) '@' (__dt_host)
end
 
function __dt_vcs_prompt --description 'Write vsc prompt'
    if set -q fish_vcs_color
        set_color $fish_vcs_color
    end
    echo -n (fish_vcs_prompt)
    set_color normal
end
   
function __dt_prompt --description 'Write the prompt'
    echo "ARGV $argv" 
    if test (count $argv) -gt 0
        set -l last_status $argv[1]
    else
        set -l last_status 0
    end
    echo "LAST_STATUS dt_prompt [$last_status]"
    echo -s -n (__dt_login) ':' (__dt_pwd) ' ' (__dt_vcs_prompt) ' ' (__dt_status $last_status)
end
 
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    if test $COLUMNS -lt 120
        set -l fish_prompt_pwd_dir_length 1
    else
        set -l fish_prompt_pwd_dir_length 0
    end

    echo "LAST STATUS fish_prompt [$last_status]"
    echo (__dt_prompt "$last_status")
    echo -n -s (__dt_suffix "$last_status") ' '
    set_color normal
end
