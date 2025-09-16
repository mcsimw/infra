{
  inputs,
  lib,
  self,
  moduleWithSystem,
  ...
}:
{
  flake.modules.nixos.tmux = moduleWithSystem (
    { system, self', inputs', ... }:
    ({ self }: { config, pkgs, lib, ... }: {
      environment.systemPackages = [
        pkgs.tmux
        self.packages.${pkgs.system}.kakoune  # Using self with pkgs.system
        self'.packages.foot                   # Using self' directly from moduleWithSystem
      ];
    }) { inherit self; }
  );
}
