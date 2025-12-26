status is-interactive; or return

if command -q zoxide
  zoxide init fish | source
end
time_since_last "Zoxide"
