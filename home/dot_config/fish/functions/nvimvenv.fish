# Autosource virtualenv; Workaround for nvim
function nvimvenv
  # Only (re)source + deactivate when the venv exists but isn't currently active in PATH.
  if set -q VIRTUAL_ENV; and test -f "$VIRTUAL_ENV/bin/activate.fish"
    set -l venv_bin "$VIRTUAL_ENV/bin"
    if not contains -- "$venv_bin" $PATH
      source "$VIRTUAL_ENV/bin/activate.fish"
      command nvim $argv
      deactivate
      return $status
    end
  end

  command nvim $argv # Run nvim program, ignore functions, builtins and aliases
end;
