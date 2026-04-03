# dotfiles

Personal configuration for a development environment, organized to be modular, maintainable, and easily reproducible across multiple machines.

This dotfiles repository manages CLI tools and the working environment such as `nvim`, `zsh`, `tmux`, `starship`, `bat`, `mise`, etc., using GNU Stow to create and manage symlinks in a structured and systematic way.


## 🎯 Goals

- **Reproducible**: set up a new machine quickly with just a few commands  
- **Modular**: each tool is an independent package  
- **Minimal**: keep only what’s necessary and avoid clutter  
- **CLI-first**: optimized for terminal-based workflows (Neovim, shell, tmux)


## ⚙️ How it works

Each directory in this repo is a **package** that mirrors the structure of `$HOME`.

**GNU Stow will:**
- create symlinks from `$HOME` → dotfiles  
- manage the full lifecycle of configs (apply / remove / update)


## 🚀 Setup

### 1. Clone repository
```zsh
git clone https://github.com/huudatt02/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install packages
**macOS** (Homebrew)
```zsh
brew bundle --file=~/dotfiles/brew/Brewfile
```

**Linux:** Install required packages manually or adapt Brewfile.

### 3. Stow packages
```zsh
stow aerospace bat ghostty mise nvim starship tmux zsh
```
or
```
stow */
```

### 4. Setup Mise (runtime manager)
Trust configuration:
```zsh
mise trust ~/.config/mise
```

Install tools:
```zsh
mise install
```

### 5. Setup Bat (syntax highlighting cache)
Build cache:
```zsh
bat cache --build
```

## 🧠 Notes
Do not edit files directly in $HOME — always modify within this repository

Keep configurations minimal and explicit

Prefer CLI tools over GUI alternatives

Use stow instead of manual symlink management

## 📜 License
MIT
