source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

eval "$(starship init zsh)"
eval "$(mise activate zsh)"

alias ls="eza --icons --group-directories-first"
