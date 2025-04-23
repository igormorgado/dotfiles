function import_env
    awk -F= '{gsub(/export /, "", $1); printf "set -gx %s %s\n", $1, $2}' $argv | source
end
