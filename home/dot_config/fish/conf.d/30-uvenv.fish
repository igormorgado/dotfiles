status is-interactive; or return

set -gx uvenv_home "$HOME/.uvenv"

if command -q uv
  # Generate completions once (avoid running `uv` on every shell startup).
  set -l uv_completion_dir "$HOME/.config/fish/completions"
  set -l uv_completion_file "$uv_completion_dir/uv.fish"
  if not test -f "$uv_completion_file"
    mkdir -p "$uv_completion_dir"
    uv generate-shell-completion fish > "$uv_completion_file"
  end
  time_since_last "Uv"
end

if command -q uvx
  set -l uv_completion_dir "$HOME/.config/fish/completions"
  set -l uvx_completion_file "$uv_completion_dir/uvx.fish"
  if not test -f "$uvx_completion_file"
    mkdir -p "$uv_completion_dir"
    uvx --generate-shell-completion fish > "$uvx_completion_file"
  end
  time_since_last "Uvx"
end

# Load base uvenv if it exists (check if no other env is already loaded
# if functions -q uvenv; and not set -q VIRTUAL_ENV; and test -d $uvenv_home/base
#   uvenv base
#   set -q DEBUG; and echo -n "Uv base "; and time_since_last
# end
