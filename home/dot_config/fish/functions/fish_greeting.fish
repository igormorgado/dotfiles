function fish_greeting  --description 'Fish greeting'
    if status is-interactive; and command -q cbonsai
        cbonsai -p
    end
end
