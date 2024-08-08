#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

declare -A cmd_exists_map
cmd_exists_map["xcode-select"]="xcode-select -p"

declare -A cmd_install_map
cmd_install_map["xcode-select"]="xcode-select --install"
cmd_install_map["brew"]="/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""

get_or_default() {
  local map=$1
  local key=$2
  local default_value=$3
  if [[ -v "${map}[$key]" ]]; then
    echo "${!map[$key]}"
  else
    echo "$default_value"
  fi
}

cmd_exists() {
  local cmd=$(get_or_default cmd_exists_map "$1" "$1")
  command -v "$cmd" >/dev/null
}

install_cmd() {
  local cmd="$1"
  echo "Checking if $cmd is installed..."
  if ! cmd_exists "$cmd"; then
    local install_cmd=$(get_or_default cmd_install_map "$1" "brew install $1")
    echo "$cmd is not installed. Installing..."
    eval "$install_cmd"
  fi
}

install_cmd "xcode-select"
install_cmd "brew"
install_cmd "stow"
install_cmd "fzf"

echo "Stowing dotfiles..." && stow .
