#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

DOTFILES_DIR="$HOME/dev/dotfiles"

log() {
  printf "==> %s\n" "$1"
}

is_installed() {
  command -v "$1" >/dev/null 2>&1
}

install_xcode_command_line_tools() {
  if xcode-select -p >/dev/null 2>&1; then
    log "Xcode Command Line Tools already installed"
    return
  fi

  log "Installing Xcode Command Line Tools..."
  xcode-select --install || true

  log "Waiting for Xcode Command Line Tools installation to finish..."
  until xcode-select -p >/dev/null 2>&1; do
    sleep 5
  done

  log "Xcode Command Line Tools installed"
}

install_homebrew() {
  if is_installed brew; then
    log "Homebrew already installed"
  else
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_setup_tools() {
  log "Installing setup tools..."
  brew install stow
}

create_development_directory() {
  if [[ -d "$HOME/dev" ]]; then
    log "Development directory ~/dev already exists"
  else
    log "Creating development directory: ~/dev"
    mkdir -p "$HOME/dev"
  fi
}

clone_dotfiles() {
  local DOTFILES_REPO="https://github.com/levzem/dotfiles.git"

  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    log "Dotfiles repo already exists..."
  else
    log "Cloning dotfiles..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  fi
}

stow_dotfiles() {
  log "Stowing dotfiles..."
  cd "$DOTFILES_DIR"
  stow .
}

setup_github_ssh_key() {
  local KEY="$HOME/.ssh/github"

  if [[ -f "$KEY" ]]; then
    log "Github SSH key already exists"
    return
  fi

  log "Generating SSH key..."

  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"

  local email
  email="$(git config --global user.email || true)"

  if [[ -z "$email" ]]; then
    read -rp "Email for SSH key: " email
  fi

  ssh-keygen -t ed25519 -C "$email" -f "$KEY" -N ""

  log "Starting ssh-agent..."
  eval "$(ssh-agent -s)"

  ssh-add --apple-use-keychain "$KEY" 2>/dev/null || ssh-add "$KEY"

  if ! grep -q "github.com" "$HOME/.ssh/config" 2>/dev/null; then
    cat >> "$HOME/.ssh/config" <<EOF

Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/github
EOF
  fi

  chmod 600 "$HOME/.ssh/config"

  pbcopy < "$KEY.pub"

  log "SSH public key copied to clipboard"
  log "Paste it into GitHub → https://github.com/settings/keys"
  log "Press ENTER when done"

  read -r
}

update_dotfiles() {
  local DOTFILES_REPO_SSH="git@github.com:levzem/dotfiles.git"
  local current_remote="$(git -C "$DOTFILES_DIR" remote get-url origin)"

  if [[ "$current_remote" == "$DOTFILES_REPO_SSH" ]]; then
    log "Dotfiles remote already uses SSH"
    return
  fi

  log "Switching dotfiles remote to SSH..."
  git -C "$DOTFILES_DIR" remote set-url origin "$DOTFILES_REPO_SSH"
}

install_apps() {
  log "Installing apps from Brewfile..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
}

configure_dock() {
  log "Configuring dock..."

  brew install dockutil

  defaults write com.apple.dock show-recents -bool false
  dockutil --remove all

  dockutil --add /System/Applications/Apps.app
  dockutil --add /Applications/Ghostty.app
  dockutil --add /Applications/Safari.app
  dockutil --add /Applications/Slack.app
  dockutil --add /System/Applications/Messages.app
  dockutil --add /System/Applications/System\ Settings.app
  dockutil --add /Users/lev/Downloads/ --section others
}

configure_macos() {
  if [[ "$OSTYPE" == darwin* ]]; then
    log "Configuring macOS preferences..."
    defaults write -g InitialKeyRepeat -int 10
    defaults write -g KeyRepeat -int 1
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
  fi
}

log "Setting up $(scutil --get ComputerName)"
install_xcode_command_line_tools
install_homebrew
install_setup_tools
create_development_directory
clone_dotfiles
stow_dotfiles
setup_github_ssh_key
update_dotfiles
install_apps
configure_dock
configure_macos

