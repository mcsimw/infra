#!/usr/bin/env bash

switch() {
  local dotfiles="${DOTFILES:-}"
  while [[ -z $dotfiles || ! -d $dotfiles ]]; do
    echo "DOTFILES is not set or invalid. Please enter the path to your config directory:"
    read -r dotfiles
    [[ -d $dotfiles ]] || echo "Directory does not exist. Try again."
  done
  nixos-rebuild switch --flake "$dotfiles#$(hostname)" --show-trace --verbose --sudo
}

boot() {
  local dotfiles="${DOTFILES:-}"
  while [[ -z $dotfiles || ! -d $dotfiles ]]; do
    echo "DOTFILES is not set or invalid. Please enter the path to your config directory:"
    read -r dotfiles
    [[ -d $dotfiles ]] || echo "Directory does not exist. Try again."
  done
  nixos-rebuild boot --flake "$dotfiles#$(hostname)" --show-trace --verbose --sudo
}
