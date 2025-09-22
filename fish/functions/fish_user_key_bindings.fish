function fish_user_key_bindings
    # I will use arrow for previous commands
    bind ctrl-p prevd-or-backward-word # prevd when empty
    bind ctrl-n nextd-or-forward-word  # nextd when empty

    # Completion
    bind ctrl-f accept-autosuggestion
    bind ctrl-r history-pager        # Search command history
    bind ctrl-s pager-toggle-search  # Search pager

    # Common CLI editing
    bind ctrl-b edit_command_buffer
    bind ctrl-l clear-screen
    bind ctrl-c clear-commandline
    bind ctrl-d delete-or-exit
    bind ctrl-z undo

    # Emacs things
    bind ctrl-e end-of-line
    bind ctrl-a beginning-of-line
    bind ctrl-h backward-kill-word           # ctrl-backspace
    bind ctrl-w backward-kill-path-component # delete previous word
    bind ctrl-u backward-kill-line           # delete to start
    bind ctrl-k kill-line                    # delete until end
    bind ctrl-t transpose-words              # swap two previous words

    bind ctrl-y yank
    bind ctrl-v fish_clipboard_paste
    bind ctrl-x fish_clipboard_copy

    # Check with `fish_key_reader` because terminals things
    # - ctrl-m == enter
    # - ctrl-i == tab
    # - ctrl-h == ctrl-backspace
    #
    # Empty keys
    # - ctrl-q
    # - ctrl-o
    # - ctrl-g
    # - ctrl-j

    # # Vim + Emacs
    # # Execute this once per mode that emacs bindings should be used in
    # fish_default_key_bindings -M insert
    #
    # # Then execute the vi-bindings so they take precedence when there's a conflict.
    # # Without --no-erase fish_vi_key_bindings will default to
    # # resetting all bindings.
    # # The argument specifies the initial mode (insert, "default" or visual).
    # fish_vi_key_bindings --no-erase insert
end
