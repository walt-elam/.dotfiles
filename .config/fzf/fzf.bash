#
# .fzf.bash
#
# Sets up FZF integration with Bash
################################################################################

# Load completion if enabled
[[ $- == *i* ]] && . ~/.config/fzf/completion.bash 2> /dev/null

# Load key bindings
[ -f ~/.config/fzf/key-bindings.bash ] && . ~/.config/fzf/key-bindings.bash

