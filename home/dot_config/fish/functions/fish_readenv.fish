function readenv --on-variable PWD --description "Read dot env if found"
    if test -r .env
        while read -l line
            set -l kv (string split -m 1 = -- $line)
            set -gx $kv # this will set the variable named by $kv[1] to the rest of $kv
        end
   end
end

