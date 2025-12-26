status is-interactive; or return

set -gx uvenv_home "$HOME/.uvenv"

if command -q uv
  uv generate-shell-completion fish | source
  time_since_last "Uv"
end

if command -q uvx
  uvx --generate-shell-completion fish | source
  time_since_last "Uvx"
end

# Load base uvenv if it exists (check if no other env is already loaded
# if functions -q uvenv; and not set -q VIRTUAL_ENV; and test -d $uvenv_home/base
#   uvenv base
#   set -q DEBUG; and echo -n "Uv base "; and time_since_last
# end
