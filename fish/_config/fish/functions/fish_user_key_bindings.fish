if status --is-interactive
    function fish_user_key_bindings --description 'Terminal bindings for interactive shell'
       bind \co 'clear; commandline -f repaint'
       bind --mode insert \co 'clear; commandline -f repaint'
       bind --sets-mode insert \co 'clear; commandline -f repaint'
    end
end

