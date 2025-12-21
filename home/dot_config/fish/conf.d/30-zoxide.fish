status is-interactive; or return

if command -q zoxide
  zoxide init fish | source
end
set -q DEBUG; and echo -n "Zoxide "; and time_since_last
