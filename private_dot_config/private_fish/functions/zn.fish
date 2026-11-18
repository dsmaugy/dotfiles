function zn --wraps z --description 'zoxide jump to a directory, then open nvim there'
    z $argv; and nvim .
end
