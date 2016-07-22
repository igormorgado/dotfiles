# Setup fzf
# ---------
if [[ ! "$PATH" == */home/igormorgado/.fzf/bin* ]]; then
  export PATH="$PATH:/home/igormorgado/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/igormorgado/.fzf/man* && -d "/home/igormorgado/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/igormorgado/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/igormorgado/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/igormorgado/.fzf/shell/key-bindings.bash"

