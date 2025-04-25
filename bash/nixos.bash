#!/usr/bin/env bash

# Prompt for DOTFILES directory if unset or invalid
_prompt_dotfiles() {
  local df="${DOTFILES:-}"
  while [[ -z $df || ! -d $df ]]; do
    echo "DOTFILES is not set or points to a non-existent directory."
    read -rp "Enter the path to your config directory: " df
    [[ -d $df ]] || echo "Directory does not exist. Try again."
  done
  printf '%s' "$df"
}

switch() {
  local dotfiles
  dotfiles="$(_prompt_dotfiles)"
  nixos-rebuild switch --flake "$dotfiles#$(hostname)" --show-trace --verbose --sudo
}

boot() {
  local dotfiles
  dotfiles="$(_prompt_dotfiles)"
  nixos-rebuild boot --flake "$dotfiles#$(hostname)" --show-trace --verbose --sudo
}

update() {
  local dotfiles
  dotfiles="$(_prompt_dotfiles)"
  nix flake update --flake "$dotfiles"
}
