#
#   .bashrc
#
#   Bourne again shell settings
################################################################################

umask 0027

# Bourne Shell Variables
########################
export CDPATH="."

export PATH=\
/usr/local/bin:\
/usr/bin:\
/bin:\
/usr/local/sbin:\
/usr/sbin:\
/sbin

# Include private .local/bin if found (Python)
if [ -d "${HOME}/.local/bin" ]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# Include private bin if found
if [ -d "${HOME}/.bin" ]; then
    export PATH="${HOME}/.bin:${PATH}"
fi


export PS1="[\A|\W]"
if [ 0 == "${UID}" ]; then
    PS1+="#"
else
    PS1+="$"
fi

PS1+=" "
export PS1
export PS2="> "

# Bourne Again Shell Veriables
##############################
export BASH_ENV=~/.bashrc
export ENV=${BASH_ENV}
export FCEDIT=vim
export HISTCONTROL=ignoredups
export HISTFILE=~/.bash_history
export HISTFILESIZE=1000
export HISTIGNORE="&"
export HISTSIZE=${HISTFILESIZE}
export HISTTIMEFORMAT="%F %T: "
unset MAILCHECK

# Set Builtin Options
#####################
set -o braceexpand
set -o hashall
set -o histexpand
set -o history
set -o ignoreeof
set -o monitor
set -o pipefail
set -o vi

# Shopt Builtin Options
#######################
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s direxpand
shopt -s dirspell
shopt -s expand_aliases
shopt -s globasciiranges
shopt -s globstar
shopt -s histappend
shopt -s interactive_comments
shopt -s lithist
shopt -s no_empty_cmd_completion
shopt -s progcomp

# Functions
###########
# Seed $RANDOM with a high-quality random 2-byte value
function seed_random()
{
    echo "Generating seed"
    RANDOM=`dd if=/dev/random bs=1 count=2 status=none | xxd | awk '{print $2;}'`
    echo "Seeded RANDOM"
}
export -f seed_random
seed_random

# Aliases
#########
alias c="clear"
alias cd..="cd .."
alias ci="vim"
alias cp="cp -i"
alias env="env | sort"
alias grep="grep --color=always -n"
alias grpe="grep"
alias la="ls -a"
alias lla="ls -la"
alias ll="ls -l"
alias ls="ls --color=auto"
alias man="man -S 2:3:4:9:1:8:5:7:6"
alias mv="mv -i"
alias pd="printf '%d\n'"
alias pep8="pycodestyle"
alias px="printf '0x%x\n'"
alias rm="rm -i"
alias src=". ~/.bashrc && echo Loaded .bashrc"
alias vibash="vim ~/.bashrc"
alias vi="vim"
alias vivim="vim ~/.vim/vimrc"
alias vncstart="vncserver -geometry 1920x1080 -depth=24 -localhost yes"
alias vs="vim -O2"
alias xdd="xxd"

# Dotfile variables
export DF_DIR=~/.dotfiles
export DF_SAVE="${DF_DIR}/saved"

# Create vim undo directory if it doesn't exist
[ ! -d ~/.vim/undo ] && mkdir -p ~/.vim/undo

# Enable bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Enable git completion
[ -f ~/.config/git/git-completion.bash ] && . ~/.config/git/git-completion.bash

# FZF
fzf_options="--case-sensitive --color=never --follow --hidden --no-config"
fzf_options="${fzf_options} --no-ignore --no-ignore-global --sort path --trim"
export FZF_DEFAULT_COMMAND="rg ${fzf_options} --files"
_fzf_compgen_path() {
    echo "${1}"
    command rg ${fzf_options} -g '!{.git,.hg,.svn}' --files ${1} 2>/dev/null \
        | sed 's@^\./@@'
}
export _fzf_compgen_path

_fzf_compgen_dir() {
    command rg ${fzf_options} -g '!{.git,.hg,.svn}' --files ${1} 2>/dev/null \
        | sed 's@^\./@@'
}
export _fzf_compgen_dir

[[ $(command -v fzf) && -f ~/.config/fzf/fzf.bash ]] && . ~/.config/fzf/fzf.bash

_fzf_complete_vi_notrigger() {
    FZF_COMPLETION_TRIGGER='' _fzf_path_completion
}

complete -o bashdefault -o default -F _fzf_complete_vi_notrigger vi
complete -o bashdefault -o default -F _fzf_complete_vi_notrigger vi

