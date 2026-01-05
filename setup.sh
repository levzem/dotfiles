#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

if ! xcode-select -p >/dev/null; then
    echo "Installing Xcode..."
    xcode-select --install
else
    echo "Xcode already installed"
fi

if ! brew info >/dev/null; then
    echo "Installing brew..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
else
    echo "Brew already installed"
fi

echo "Installing homebrew dependencies..."
brew bundle check >/dev/null || brew bundle install

echo "Stowing dotfiles..." && stow .
