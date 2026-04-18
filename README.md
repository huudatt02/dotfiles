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

### 1. Setup GitHub SSH
```zsh
# Generate a new SSH key:
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add SSH key to the ssh-agent

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add your SSH private key to the ssh-agent and store your passphrase in the keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Add the SSH key to GitHub
pbcopy < ~/.ssh/id_ed25519.pub

# Test SSH connection
ssh -T git@github.com
```

### 2. Git Global Commands
To set your global Git user name and email, run the following commands in your terminal:
```zsh
# Set your global Git username
git config --global user.name "Your Name"

# Set your global Git email
git config --global user.email "you@example.com"
```

### 3. Clone repository
```zsh
git clone https://github.com/huudatt02/dotfiles.git ~/dotfiles
```

### 4. Install packages
**macOS** (Homebrew)
```zsh
brew bundle --file=~/dotfiles/brew/Brewfile
```

**Linux:** Install required packages manually or adapt Brewfile.

### 5. Stow packages
```zsh
cd ~/dotfiles

stow aerospace bat ghostty mise nvim starship tmux zsh
```

### 6. Setup Mise (runtime manager)
```zsh
# Trust configuration:
mise trust ~/.config/mise

# Install tools:
mise install
```

### 7. Setup Bat (syntax highlighting cache)
Build cache:
```zsh
bat cache --build
```

### 8. Login to GitHub CLI
```zsh
# Authenticate GitHub CLI so you can interact with GitHub from terminal:
gh auth login

# Check your login status:
gh auth status
```
## 🧠 Notes
Do not edit files directly in $HOME — always modify within this repository

Keep configurations minimal and explicit

Prefer CLI tools over GUI alternatives

Use stow instead of manual symlink management

## 📜 License
![MIT License](https://img.shields.io/badge/license-MIT-green)
