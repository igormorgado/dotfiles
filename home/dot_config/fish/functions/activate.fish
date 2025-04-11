function activate --description "Activate venv"

  if test -d ".venv" 
    set VENV ".venv" 
  else if test -d "venv" 
    set VENV "venv" 
  end

  if set -q VENV 
    source $VENV/bin/activate.fish
  else
    echo "NO venv found"
  end

end
