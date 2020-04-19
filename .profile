#
#   .profile
#
#   Bourne shell settings
################################################################################

# Load .bashrc if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
        exit
    fi
fi

# Include private bin if found
if [ -d "$HOME/.bin" ]; then
    PATH="$HOME/.bin:$PATH"
fi

