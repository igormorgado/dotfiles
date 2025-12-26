set -l HOMEBREW_ROOT /opt/homebrew
if test -d $HOMEBREW_ROOT
  fish_add_path $HOMEBREW_ROOT/bin
  $HOMEBREW_ROOT/bin/brew shellenv | source
  time_since_last "Homebrew"
end
