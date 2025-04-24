function __dt_git_prompt --description 'Write out the git prompt'
    set -q __fish_git_prompt_showdirtystate
    or set -g __fish_git_prompt_showdirtystate 1
    set -q __fish_git_prompt_showuntrackedfiles
    or set -g __fish_git_prompt_showuntrackedfiles 1
    set -q __fish_git_prompt_showcolorhints
    or set -g __fish_git_prompt_showcolorhints 1
    set -q __fish_git_prompt_color_untrackedfiles
    or set -g __fish_git_prompt_color_untrackedfiles yellow
    set -q __fish_git_prompt_char_untrackedfiles
    or set -g __fish_git_prompt_char_untrackedfiles '?'
    set -q __fish_git_prompt_color_invalidstate
    or set -g __fish_git_prompt_color_invalidstate red
    set -q __fish_git_prompt_char_invalidstate
    or set -g __fish_git_prompt_char_invalidstate '!'
    set -q __fish_git_prompt_color_dirtystate
    or set -g __fish_git_prompt_color_dirtystate blue
    set -q __fish_git_prompt_char_dirtystate
    or set -g __fish_git_prompt_char_dirtystate '*'
    set -q __fish_git_prompt_char_stagedstate
    or set -g __fish_git_prompt_char_stagedstate '✚'
    set -q __fish_git_prompt_color_cleanstate
    or set -g __fish_git_prompt_color_cleanstate green
    set -q __fish_git_prompt_char_cleanstate
    or set -g __fish_git_prompt_char_cleanstate '✓'
    set -q __fish_git_prompt_color_stagedstate
    or set -g __fish_git_prompt_color_stagedstate yellow
    set -q __fish_git_prompt_color_branch_dirty
    or set -g __fish_git_prompt_color_branch_dirty red
    set -q __fish_git_prompt_color_branch_staged
    or set -g __fish_git_prompt_color_branch_staged yellow
    set -q __fish_git_prompt_color_branch
    or set -g __fish_git_prompt_color_branch green
    set -q __fish_git_prompt_char_stateseparator
    or set -g __fish_git_prompt_char_stateseparator '⚡'

    # fish_git_prompt '%s'
end

function __dt_user --description 'Write username colored'
    set -q $fish_color_user; and set_color $fish_color_user
    echo -n $USER
    set_color normal
end


function __dt_color_host --description "Write host color. Different if remote"
    set -q fish_color_host; and set_color $fish_color_host
    set -q SSH_TTY; and set -q fish_color_host_remote; and set_color $fish_color_host_remote
end


function __dt_host --description 'Write hostname colored'
    __dt_color_host
    echo -n (prompt_hostname)
    set_color normal
end


function __dt_pwd --description 'Write pwd colored'
    set -q fish_color_cwd; and set_color $fish_color_cwd

    # is it root?
    functions -q fish_is_root_user;
        and fish_is_root_user;
        and set -q fish_color_cwd_root;
        and set_color $fish_color_cwd_root

    echo -n (prompt_pwd)
    set_color normal
end


function __dt_status --description 'Write colored status'
    set -q argv[1]; and set -l last_status $argv[1]; or set -l last_status 0

    if test "$last_status" != "0"
        set -q fish_color_error; and set_color $fish_color_error
        echo -n "✘ $last_status"
    end
    set_color normal
end


function __dt_suffix --description 'Write the prompt'
    set -q argv[1]; and set -l last_status $argv[1]; or set -l last_status 0

    set -l suffix '❯'
    functions -q fish_is_root_user; and fish_is_root_user; and set suffix '#'

    set -q fish_color_prompt; and set_color $fish_color_prompt

    test "$last_status" != "0";
        and set -q fish_color_error;
        and set_color $fish_color_error

    echo -n "$suffix"
    set_color normal
end
 

function __dt_login --description 'Write the login information'
    echo -n -s (__dt_user) (set_color white --dim) '@' (set_color normal) (__dt_host)
end
 

function __dt_vcs_prompt --description 'Write vsc prompt'
    __dt_git_prompt
    set -q fish_vcs_color; and set_color $fish_vcs_color
    echo -n (fish_vcs_prompt)
    set_color normal
end
   

function __dt_prompt --description 'Write the prompt'
    set -q argv[1]; and set -l last_status $argv[1]; or set -l last_status 0
    echo -s -n (__dt_login) (set_color white --dim) ':' (set_color normal) (__dt_pwd) ' ' (__dt_vcs_prompt) ' ' (__dt_status $last_status)
end
 

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    if test $COLUMNS -lt 120; 
        set -g fish_prompt_pwd_dir_length 1
        set -g fish_prompt_pwd_full_dirs 1
    else
        set -g fish_prompt_pwd_dir_length 0
    end

    echo (__dt_prompt "$last_status")
    echo -n -s (__dt_suffix "$last_status") ' '

    set_color normal
end
