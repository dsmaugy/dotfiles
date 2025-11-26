set PYENV_ROOT "$HOME/.pyenv"

fish_add_path /home/darwin/.local/bin
fish_add_path /home/darwin/go/bin

pyenv init - | source

alias gcm='git checkout main'
alias ccat='pygmentize -g'

set ELECTRON_OZONE_PLATFORM_HINT wayland
