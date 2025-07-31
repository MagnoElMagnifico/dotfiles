function fish_greeting
    # Run fastfetch on startup if:
    #   - the command exists
    #   - not running inside Vim or Neovim
    #   - not running inside tmux or zellij
    #   - not running inside SSH
    if type -q fastfetch; \
        and not set -q NVIM; \
        and not set -q VIMRUNTIME; \
        and not set -q TMUX; \
        and not set -q ZELLIJ; \
        and not set -q SSH_TTY
            command fastfetch
    end
end
