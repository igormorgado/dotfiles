if test -d /opt/conda
  set __conda_setup (/opt/conda/bin/conda 'shell.fish' 'hook' 2> /dev/null)

  if test $status -eq 0
      eval "$__conda_setup"
  else
      set conda_fish_conf "/opt/conda/etc/fish/conf.d/conda.fish"
      if test -f $conda_fish_conf
          source $conda_fish_conf
      else
          fish_add_path "/opt/conda/bin"
    end
  end
  set -e __conda_setup
  set -e conda_fish_conf
end
