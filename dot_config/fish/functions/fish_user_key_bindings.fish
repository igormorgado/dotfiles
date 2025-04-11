if status --is-interactive
    function fish_user_key_bindings --description 'Terminal bindings for interactive shell'
       bind \ct 'clear; commandline -f repaint'
       bind --mode insert \ct 'clear; commandline -f repaint'
       bind --sets-mode insert \ct 'clear; commandline -f repaint'
    end
end

