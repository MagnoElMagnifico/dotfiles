function fish_user_key_bindings
    fish_default_key_bindings

    # TODO: better bindings (some of them are picked by the terminal)
    # bind ctrl-f accept-autosuggestion
    # bind ctrl-s edit_command_buffer
    # bind ctrl-t transpose-words
    # bind ctrl-m __fish_list_current_token # TODO: does not work
    #
    # # As documentation
    # bind ctrl-w backward-kill-path-component # delete previous word
    # bind ctrl-u backward-kill-line           # delete to start
    # bind ctrl-k kill-line                    # delete until end

    # # Execute this once per mode that emacs bindings should be used in
    # fish_default_key_bindings -M insert
    #
    # # Then execute the vi-bindings so they take precedence when there's a conflict.
    # # Without --no-erase fish_vi_key_bindings will default to
    # # resetting all bindings.
    # # The argument specifies the initial mode (insert, "default" or visual).
    # fish_vi_key_bindings --no-erase insert
    #
    # #### Custom bindings ####
    # bind -M insert ctrl-g accept-autosuggestion
end
