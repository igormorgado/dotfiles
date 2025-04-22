function fish_greeting  --description 'Fish greeting'
    if set -q DISPLAY; and command -q cbonsai
        cbonsai -p
    end
end
