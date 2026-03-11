export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

alias ls="eza -1 --icons --group-directories-first"

eval "$(starship init zsh)"
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"

