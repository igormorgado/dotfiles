function fish_greeting  --description 'Fish greeting'
    if set -q DISPLAY
        ~/bin/cbonsai -p
    end
end
