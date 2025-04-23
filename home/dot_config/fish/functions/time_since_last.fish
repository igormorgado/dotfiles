function time_since_last --description 'Print elapsed time since last call if >1ms'
    # get current time in nanoseconds
    set -l now_ns (date +%s%N)

    if set -q __time_since_last_ns
        # compute elapsed nanoseconds
        set -l elapsed_ns (math "$now_ns - $__time_since_last_ns")

        # only show if more than 1 ms (1 000 000 ns)
        if test $elapsed_ns -gt 1000000
            # compute milliseconds as a float
            set -l ms_float (math "$elapsed_ns / 1000000")
            # strip off the decimal part to get an integer
            set -l elapsed_ms (string replace -r '\..*' '' -- $ms_float)
            printf "Δ %s ms\n" $elapsed_ms
        end
    end

    # store for next time
    set -g __time_since_last_ns $now_ns
end
