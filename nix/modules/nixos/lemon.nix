{
  inputs,
  lib,
  self,
  ...
}:
{
  flake.modules.nixos.tmux =
    let
      moduleFunc = { self }: { config, pkgs, lib, ... }: {
        environment.systemPackages = [
          pkgs.gay
          self.packages.${pkgs.system}.kakoune
        ];
      };
    in
    moduleFunc { inherit self; };
}
