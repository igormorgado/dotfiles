function uvenv --description "Creates or loads an uv virtual environment."
  argparse 'p/python=' 'l/local' 'y/yes' 'h/help' 's/show' -- $argv 
  or return 1

  set env_file ".python-uversion"

  # Handle help request
  if set -q _flag_help
    _uvenv_print_help $env_file
    return 0
  end

  # Ensure uvenv_home exists
  set -q uvenv_home; or set -g uvenv_home "$HOME/.uvenv"
  mkdir -p "$uvenv_home"

  if set -q _flag_show
    for venv_path in $uvenv_home/*
        set venv (basename $venv_path)
        if test -x "$venv_path/bin/python"
            set python_version ("$venv_path/bin/python" --version)
        printf "%-15s %s\n" "$venv" "$python_version"
        end
    end
    return 0
  end
  # Try to load an environment name from:
  # 1. First argument
  # 2. Local environment file
  # 3. Currently active environment
  set -l env_name
  set -l env_path
  set -l from_file false
  set -l activate_path "/bin/activate.fish"
  
  # Check if first argument is a valid environment
  if test (count $argv) -gt 0 -a -f "$uvenv_home/$argv[1]$activate_path"
    set env_name $argv[1]
    set env_path "$uvenv_home/$env_name"
    set -e argv[1]  # Consume first argument
  else if test -r $env_file
    # Try to load from environment file
    set -l temp_env_name (head -n 1 $env_file)
    if test -f "$uvenv_home/$temp_env_name$activate_path"
      set env_name $temp_env_name
      set env_path "$uvenv_home/$env_name"
      set from_file true
    end
  end

  # Create a new environment if needed
  if test -z "$env_name"
    # If we already have an active virtual environment, use it
    if test -d "$VIRTUAL_ENV"
      set env_name "$VIRTUAL_ENV_PROMPT"
      set env_path "$VIRTUAL_ENV"
      echo "Environment `$env_name` already active. Skipping activation."
    else if test (count $argv) -gt 0
      # Create a new environment with the first argument as name
      set env_name $argv[1]
      set env_path "$uvenv_home/$env_name"
      set -e argv[1]  # Consume first argument
      
      set -l extra_message ""
      set -l extra_args
      
      if set -q _flag_python
        set extra_message " with Python $_flag_python"
        set extra_args --python $_flag_python
      end
      
      if not set -q _flag_yes
        echo "No env set and argument does not seems a valid env."
        echo "Do you wish to proceed and create the `$env_name`?"
        echo "Press CTRL-C to stop or ENTER to proceed."
        read -l input || return 0
      end
      echo "Creating virtual environment: `$env_name$extra_message`."
      uv venv "$env_path" $extra_args
      or begin 
        echo "Failed to create virtual environment. Check uv output."
        return 1
      end
      
      if set -q _flag_local
        echo "Creating local `$env_file` to `$env_name`."
        echo "$env_name" > "$env_file"
        or echo "Warning: Failed to create $env_file file."
      end
      
      echo "To activate: `source $env_path/bin/activate.fish`"
      echo "         or: uvenv $env_name"
      set -q _flag_local; and echo "         or: uvenv , when inside" (pwd)
    else
      # No arguments and no environment found
      _uvenv_print_help $env_file
      return 1
    end
  end

  # Sanity check for valid environment
  if not test -f "$env_path$activate_path"
    echo "Could not find a valid environment at `$env_path`. Exiting."
    return 1
  end

  # Activate the environment if it's not already active
  if test "$VIRTUAL_ENV" != "$env_path"
    source "$env_path$activate_path"
    echo -n "Activated virtual environment: `$env_name`"
    $from_file; and echo " from `$env_file`"; or echo
  end

  # Install packages if more args are passed
  if test (count $argv) -gt 0
    echo "Using environment `$env_path`."
    echo "Installing packages: $argv"
    uv pip install --python "$env_path/bin/python" $argv
    or echo "Failed to install packages. Check uv output."
  end
end

# Helper function to print help message
function _uvenv_print_help --argument-names env_file
  set_color normal
  echo "Creates or loads an uv virtual environment."
  echo ""
  set_color blue
  echo "Usage: uvenv [env_name] [--help] [--python VERSION] [--local] [packages...]"
  set_color normal
  echo ""
  echo "Options:"
  set_color yellow
  echo "  --help/-h               This help message."
  echo "  --local/-l              Creates a local `$env_file` that points to venv."
  echo "  --yes/-y                Assumes yes in all interactions."
  echo "  --show/-x               Shows all installed virtualenvs and versions."
  echo "  --python/-p VERSION     Uses given Python version. Must be installed."
  set_color normal
  echo ""
  echo "Behavior:"
  echo "  - With no arguments: Loads environment from `$env_file` if it exists"
  echo "  - With env_name: Activates existing or creates new environment"
  echo "  - With env_name and packages: Also installs specified packages"
  echo "  - With active venv and packages: Install packages in active venv"
  echo ""
  echo "Examples:"
  set_color green
  echo "  uvenv myproject         # Create or activate 'myproject' environment"
  echo "  uvenv -l myproject      # Same, but also create local reference file"
  echo "  uvenv -p 3.10 webdev    # Create environment with Python 3.10"
  echo "  uvenv web flask requests # Create 'web' and install packages"
  set_color normal
end
