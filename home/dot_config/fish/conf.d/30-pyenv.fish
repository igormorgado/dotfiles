set -l PYENV_ROOT ~/.pyenv
if test -d $PYENV_ROOT
  fish_add_path $PYENV_ROOT/bin
  if command -q pyenv
    pyenv init - | source
    pyenv virtualenv-init - | source
  end
  set -q DEBUG; and echo -n "Pyenv "; and time_since_last
end


