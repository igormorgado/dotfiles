function myip --description 'Display external/public IP address'
    set -l endpoints \
        https://api.ipify.org \
        https://checkip.amazonaws.com \
        https://icanhazip.com

    for endpoint in $endpoints
        set -l ip (curl --silent --show-error --fail --location --max-time 5 $endpoint 2>/dev/null | string trim)

        if test -n "$ip"
            and string match --quiet --regex '^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$|^[0-9A-Fa-f:]+$' -- $ip
            echo $ip
            return 0
        end
    end

    echo 'myip: unable to determine external IP' >&2
    return 1
end
