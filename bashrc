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
shopt -s globstar       # use ** for recursive wildcard

bind "set completion-ignore-case on"

### PROMPT ###
# Using Nerd Fonts: "<current directory> <nf-md-chevron_triple_right> " all in green
export PS1=$'\[\033[1;32m\]\W \U000f0dbb \[\033[0m\]'

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
alias diff='diff --color=always -u'
alias ip='ip --color=auto'

alias cat='bat --theme="Visual Studio Dark+"'
alias icat='wezterm imgcat'

# Confirm before overwriting
alias rm='rm -iv'
alias mv='mv -iv'
alias cp='cp -iv'

# Startup program
[[ -x $(command -v fastfetch) ]] && fastfetch
