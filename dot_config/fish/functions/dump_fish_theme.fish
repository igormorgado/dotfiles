function dump_fish_theme_json
    set -l theme_name "Unnamed"
    set -l theme_uuid (uuidgen)

    if count $argv > /dev/null
        set theme_name $argv[1]
    end

    if count $argv -ge 2
        set theme_uuid $argv[2]
    end

    echo '{'
    echo "  \"name\": \"$theme_name\","
    echo "  \"uuid\": \"$theme_uuid\","
    echo '  "colors": {'

    set -l vars (set -U | grep '^fish_color')
    set -l last_idx (math (count $vars) - 1)

    for idx in (seq 0 $last_idx)
        set -l var $vars[$idx]
        set -l val (string escape -- (set -U $var))
        set -l comma ","
        if test $idx -eq $last_idx
            set comma ""
        end
        echo "    \"$var\": \"$val\"$comma"
    end

    echo '  }'
    echo '}'
end
