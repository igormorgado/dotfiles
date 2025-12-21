function google_login --description 'Login in GCP only if needed'
    if not command -q gcloud
        return 1
    end

    set -l token (gcloud auth application-default print-access-token 2>/dev/null)
    set -l status_token $status

    # Ensure cache directory exists for timestamp file
    set -l timestamp_file ~/.cache/google_login_last_run
    mkdir -p (dirname $timestamp_file)

    if test $status_token -eq 0 -a -n "$token"
        date +%s > $timestamp_file
        return 0
    end

    echo "You're not authenticated at Google Cloud Platform. CTRL-C to skip it"
    gcloud auth login --update-adc
    or return $status

    # Only update timestamp if login succeeded
    date +%s > $timestamp_file
end
