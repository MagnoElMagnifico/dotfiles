# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### EXPORT ###
export TERM='xterm-256color'             # Colors
export HISTCONTROL=ignoredups:erasedups  # Ignore duplicates entries
export HISTSIZE=1000
export HISTFILESIZE=2000
export EDITOR=nvim

### OTHER SCRIPTS ###
# Rust & cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

### SHOPT ###
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrects cd misspellings
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s histappend     # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control

bind "set completion-ignore-case on"

### PROMPT ###
# Using Fira Code or Cascadia Code with ligadures on
export PS1="\e[32m\w |>\e[m "

### PATH ###
export PATH=$PATH:/opt/bin

### ALIAS ###
alias   ..='cd ..'
alias  ...='cd ../..'
alias ....='cd ../../..'
alias   .4='cd ../../../..'
alias   .5='cd ../../../../..'

alias grep='grep --color=always'
alias ls='ls --color=always --group-directories-first -h'
alias ll='ls -l'
alias la='ls -lA'
alias df='df -h'

# Confirm before overwriting
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# TODO: alias cat='bat'
