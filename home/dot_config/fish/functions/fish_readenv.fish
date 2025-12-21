function readenv --on-variable PWD --description "Read dot env if found"
    if not test -r .env
        return
    end

    # Load simple KEY=VALUE pairs; skip comments/blank lines; avoid clobbering existing vars
    while read -l line
        string match -rq '^\s*(#|$)' -- $line; and continue

        set -l kv (string split -m 1 '=' -- $line)
        set -l key (string trim -- $kv[1])
        set -l value (string trim -- $kv[2])

        # Skip invalid variable names to avoid eval issues
        string match -rq '^[A-Za-z_][A-Za-z0-9_]*$' -- $key; or continue

        # Strip surrounding quotes
        if string match -rq '^".*"$' -- $value
            set value (string replace -r '^"(.*)"$' '$1' -- $value)
        else if string match -rq "^'.*'$" -- $value
            set value (string replace -r "^'(.*)'$" '$1' -- $value)
        end

        # Skip if already set in the environment
        if eval "set -q $key"
            continue
        end

        set -gx $key $value
    end < .env
end
