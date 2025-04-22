function readenv --on-variable PWD --description "Read dot env if found"
    if test -r .env
        while read -l line
            set -l kv (string split -m 1 = -- $line)
            set -gx $kv
        end
   end
end

