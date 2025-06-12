function ls --wraps='ls' --description 'List files'
    command ls --color=auto --group-directories-first -hv $argv
end
