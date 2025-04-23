# fish function to determine whether to run Google login based on delay
# Usage: should_run_google_login [delay_seconds]
# If delay_seconds is not provided, defaults to 12 hours (43200 seconds)
function should_run_google_login --description "Verify time last google login"
    # Optional delay parameter in seconds
    set -l delay_seconds $argv[1]
    if test -z "$delay_seconds"
        set -l delay_seconds 43200
    end

    # Timestamp cache file
    set -l timestamp_file ~/.cache/google_login_last_run
    # Current epoch time
    set -l current_time (date +%s)

    # Check if timestamp file exists
    if test -f $timestamp_file
        set -l last_run_time (cat $timestamp_file)
        set -l time_since_last_run (math "$current_time - $last_run_time")
        # If elapsed time is less than the delay, do not run
        if test $time_since_last_run -lt $delay_seconds
            # Don't run
            return 1
        end
    end

    # Update timestamp and allow run
    echo $current_time > $timestamp_file
    # Run
    return 0
end
