export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export BAT_THEME="tokyonight_night"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --strip-cwd-prefix'

export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --level=2 --icons --color=always --group-directories-first {}; else bat -n --color=always --line-range=:500 {}; fi'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --icons --color=always --group-directories-first {}'"

export FZF_DEFAULT_OPTS="
  --highlight-line
  --info=inline-right
  --ansi
  --layout=reverse
  --border=none
  --color=bg+:#2e3c64
  --color=bg:-1
  --color=border:#27a1b9
  --color=fg+:#c0caf5
  --color=fg:#c0caf5
  --color=gutter:#45475A
  --color=header:#9ece6a
  --color=hl+:#7dcfff
  --color=hl:#bb9af7
  --color=info:#7aa2f7
  --color=marker:#9ece6a
  --color=pointer:#7dcfff
  --color=prompt:#7dcfff
  --color=query:#c0caf5:regular
  --color=scrollbar:#27a1b9
  --color=separator:#ff9e64
  --color=spinner:#9ece6a
"

source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    hlissner/zsh-autopair \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"

source <(fzf --zsh)

alias vim='nvim'
alias v='nvim'
alias n='nvim'

alias mkdir='mkdir -pv'

alias lzg='lazygit'
alias lzd='lazydocker'
alias dk='docker'
alias dkc='docker-compose'

alias cls='colima start'
alias clt='colima stop'
alias clrs='colima restart'
alias clst='colima status'

alias ls='eza --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'

eval "$(starship init zsh)"

