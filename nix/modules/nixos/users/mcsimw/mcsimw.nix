{ moduleWithSystem, self, ... }:
{
  flake.modules.nixos.infra =
    (
      { self }:
      moduleWithSystem (
        { self', ... }:
        {
          config,
          lib,
          ...
        }:
        let
          cfg = config.analfabeta.users.mcsimw.enable;
        in
        {
          options.analfabeta.users.mcsimw.enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          config = lib.mkIf cfg {
            users.users.mcsimw = {
              description = "Maor Haimovitz";
              isNormalUser = true;
              linger = true;
              extraGroups = [
                "wheel"
              ]
              ++ (import (self + /nix/modules/nixos/users/_extraGroups.nix) { inherit config lib; });
              uid = 1000;
              initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
              packages = with self'.packages; [
                git
                nvim
              ];
            };
          };
        }
      )
    )
      { inherit self; };
}
