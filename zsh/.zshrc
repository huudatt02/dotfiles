export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"

export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export BAT_THEME='tokyonight_moon'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git --strip-cwd-prefix'

export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --level=2 --icons --color=always --group-directories-first {}; else bat -n --color=always --line-range=:500 {}; fi'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --icons --color=always --group-directories-first {}'"

export FZF_DEFAULT_OPTS="
  --highlight-line
  --info=inline-right
  --ansi
  --prompt=' '
  --layout=reverse
  --border=none
  --color=bg+:#2d3f76
  --color=bg:-1
  --color=border:#589ed7
  --color=fg:#c8d3f5
  --color=gutter:#3b4261
  --color=header:#ff966c
  --color=hl+:#65bcff
  --color=hl:#65bcff
  --color=info:#545c7e
  --color=marker:#65bcff
  --color=pointer:#65bcff
  --color=prompt:#65bcff
  --color=query:#c8d3f5:regular
  --color=scrollbar:#589ed7
  --color=separator:#ff966c
  --color=spinner:#ff966c
"

source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh

# Zsh plugins
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

autoload -Uz compinit
compinit

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:(cd|z):*' fzf-preview '
  eza --tree --level=2 --color=always --group-directories-first $realpath
'
zstyle ':fzf-tab:complete:(vim|nvim|cat):*' fzf-preview '
  bat --color=always --style=numbers --line-range=:200 $realpath
'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

# Initialize tools
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

source <(fzf --zsh)

# History setup
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

alias vim='nvim'
alias v='nvim'
alias n='nvim'

alias mkdir='mkdir -p'

alias lzg='lazygit'
alias lzd='lazydocker'
alias dk='docker'
alias dc='docker-compose'

alias cls='colima start'
alias clt='colima stop'
alias clrs='colima restart'
alias clst='colima status'

alias ls='eza --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'

