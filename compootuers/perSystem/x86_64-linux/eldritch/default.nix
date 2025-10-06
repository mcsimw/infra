{ self, system, ... }:
let
  sources = import (self + /npins);
in
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    ./bootloader.nix
  ];
  environment.systemPackages = [ (import sources.ghostty).packages.${system}.default ];
}
