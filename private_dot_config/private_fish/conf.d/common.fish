
set PYENV_ROOT "$HOME/.pyenv"

fish_add_path /home/darwin/.local/bin

pyenv init - | source

alias gcm='git checkout main'
alias ccat='pygmentize -g'
