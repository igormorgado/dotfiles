set -l BASHER_ROOT $HOME/.basher
if test -d $BASHER_ROOT
  set basher $BASHER_ROOT/bin
  fish_add_path $basher
  status --is-interactive; and . (basher init - fish | psub)
  set -q DEBUG; and echo -n "Basher "; and time_since_last
end

