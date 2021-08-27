function fish_greeting  --description 'Fish greeting'
    if set -q DISPLAY
        cbonsai -p
    end
end
