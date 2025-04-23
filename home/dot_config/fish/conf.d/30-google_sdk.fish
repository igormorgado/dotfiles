# The next line updates PATH for the Google Cloud SDK.
set -l GOOGLE_SDK_PATH '/opt/google-cloud-sdk/path.fish.inc'
if test -f $GOOGLE_SDK_PATH
    source $GOOGLE_SDK_PATH
    set -q DEBUG; and echo -n "Google SDK "; and time_since_last
end

# Verify if need to login at google
set -l delay_time 43200  # 12h
if      status is-interactive;
    and status is-login;
    and functions -q google_login;
    and should_run_google_login $delay_time
    google_login
    set -q DEBUG; and echo -n "Google Login "; and time_since_last
end


