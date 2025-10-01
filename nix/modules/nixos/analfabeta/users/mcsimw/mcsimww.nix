{
  moduleWithSystem,
  self,
  lib,
  ...
}:
{
  flake.modules.nixos.mcsimww = moduleWithSystem (
    { self' }:
    { config, ... }:
    let
      cfg = config.analfabeta.users.mcsimw;
    in
    {
      options.analfabeta.users.mcsimw = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
        };
        uid = lib.mkOption {
          type = lib.types.int;
          default = 1000;
          description = "User ID for mcsimw";
        };
      };
      config = lib.mkIf cfg.enable {
        users.users.mcsimw = {
          description = "Maor Haimovitz";
          isNormalUser = true;
          linger = true;
          extraGroups = [
            "wheel"
          ]
          ++ (import (self + /nix/modules/nixos/analfabeta/users/_extraGroups.nix) { inherit config lib; });
          inherit (cfg) uid;
          initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
          packages = with self'.packages; [
            git
            nvim
          ];
        };
      };
    }
  );
}
