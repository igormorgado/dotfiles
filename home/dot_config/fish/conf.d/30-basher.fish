set -l BASHER_ROOT $HOME/.basher
if test -d $BASHER_ROOT
  set basher $BASHER_ROOT/bin
  fish_add_path $basher
  status --is-interactive; and . (basher init - fish | psub)
  time_since_last "Basher"
end

