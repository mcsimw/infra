#!/usr/bin/env bash

switch() {
  local df="${DOTFILES:-}"
  while [[ -z $df || ! -d $df ]]; do
    echo "DOTFILES is not set or points to a non-existent directory."
    read -rp "Enter the path to your config directory: " df
    [[ -d $df ]] || echo "Directory does not exist. Try again."
  done
  nixos-rebuild switch --flake "$df#$(hostname)" --show-trace --verbose --sudo
}

boot() {
  local df="${DOTFILES:-}"
  while [[ -z $df || ! -d $df ]]; do
    echo "DOTFILES is not set or points to a non-existent directory."
    read -rp "Enter the path to your config directory: " df
    [[ -d $df ]] || echo "Directory does not exist. Try again."
  done
  nixos-rebuild boot --flake "$df#$(hostname)" --show-trace --verbose --sudo
}

update() {
  local df="${DOTFILES:-}"
  while [[ -z $df || ! -d $df ]]; do
    echo "DOTFILES is not set or points to a non-existent directory."
    read -rp "Enter the path to your config directory: " df
    [[ -d $df ]] || echo "Directory does not exist. Try again."
  done
  nix flake update --flake "$df"
}
