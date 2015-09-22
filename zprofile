# vim:set ft=zsh
export GPG_TTY=$(tty)
export ZSH_THEME="flazz"

export PATH=$HOME/.local/bin:$PATH
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
