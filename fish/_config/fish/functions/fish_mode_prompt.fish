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
