if status --is-interactive
    function fish_user_key_bindings --description 'Terminal bindings for interactive shell'
       bind --erase --preset ctrl-l
       # bind \ct 'clear; commandline -f repaint'
       # bind --mode insert \ct 'clear; commandline -f repaint'
       # bind --sets-mode insert \ct 'clear; commandline -f repaint'
       bind \ct 'status test-terminal-feature scroll-content-up && commandline -f scrollback-push' clear-screen
       bind --mode insert \ct 'status test-terminal-feature scroll-content-up && commandline -f scrollback-push' clear-screen
       bind --sets-mode insert \ct 'status test-terminal-feature scroll-content-up && commandline -f scrollback-push' clear-screen
    end
end

