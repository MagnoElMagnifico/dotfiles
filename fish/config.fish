#### PROFILE ####
set -gx TERM xterm-256color
set -gx HISTSIZE 1000
set -gx HISTFILESIZE 3000

# Programs
set -gx BROWSER brave-browser
set -gx EDITOR nvim
set -gx VISUAL kwrite
set -gx MANPAGER less
set -gx PAGER less

# PATH
if test -d $HOME/.opam/default/bin
    fish_add_path $HOME/.opam/default/bin
end

if test -d $HOME/.cargo/bin
    fish_add_path -g $HOME/.cargo/bin
end

if test -d /opt/bin
    fish_add_path -g /opt/bin
end

# Set XDG basedirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache

#### INTERACTIVE ####

# TODO:
# cdf() {
#     cd $(find $1 -type d -not -path '*/[@.]*' | fzf)
# }
#
# dvim() {
#     cdf $1 && nvim .
# }
#
# # Fuzzy find
# alias fvim='nvim $(fzf)'

if status is-interactive
    # NOTE: when the list is big enough, move to conf.d/ directory

    #### ALIASES ####
    # Navigation
    alias ..='cd ..'
    alias ...='cd ../..'
    alias .3='cd ../../..'
    alias .4='cd ../../../..'
    alias .5='cd ../../../../..'

    # Activate colors and flags
    alias ip='ip --color=auto'
    alias diff='diff --color=auto -u'
    alias df='df -h'

    alias rm='rm -iv'
    alias mv='mv -iv'
    alias cp='cp -iv'

    alias cat='bat --theme="Visual Studio Dark+"'
    alias icat='wezterm imgcat'

    #### ABBREVIATIONS ####
    # Git
    abbr --add gs 'git status'
    abbr --add gc 'git commit -m ""'
    abbr --add gd 'git diff'
    abbr --add ga 'git add'

    # Recurrently used commands
    abbr --add up 'sudo dnf update && flatpak update'

    #### BINDINGS ####
    bind ctrl-g accept-autosuggestion
end

