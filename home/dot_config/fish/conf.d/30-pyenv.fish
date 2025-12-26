if not status is-interactive; and not status is-login
  return
end

set -l PYENV_ROOT ~/.pyenv
if test -d $PYENV_ROOT
  fish_add_path $PYENV_ROOT/bin
  if command -q pyenv
    pyenv init - | source
    pyenv virtualenv-init - | source
  end
  time_since_last "PyEnv"
end

