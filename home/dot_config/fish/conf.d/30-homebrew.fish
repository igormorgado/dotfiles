set -l HOMEBREW_ROOT /opt/homebrew
if test -d $HOMEBREW_ROOT
  fish_add_path $HOMEBREW_ROOT/bin
  $HOMEBREW_ROOT/bin/brew shellenv | source
  set -q DEBUG; and echo -n "Homebrew "; and time_since_last
end
