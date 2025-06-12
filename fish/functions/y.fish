# Modified from: https://yazi-rs.github.io/docs/quick-start
function y --description "Run yazi and change cwd"
    if not type -q yazi
        echo "yazi is not installed"
        return 1
    end
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end
