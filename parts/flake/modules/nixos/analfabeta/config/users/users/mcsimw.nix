{
  moduleWithSystem,
  lib,
  self,
  ...
}:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self', inputs' }:
    { config, ... }:
    {
      users.users.mcsimw = {
        enable = lib.mkDefault false;
        description = "Maor Haimovitz";
        isNormalUser = true;
        linger = true;
        extraGroups = [
          "wheel"
        ]
        ++ (import "${self}/parts/flake/modules/nixos/analfabeta/config/users/_extraGroups.nix" {
          inherit config lib;
        });
        uid = lib.mkDefault 1000;
        initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
        packages = [
          self'.packages.git
          self'.packages.tmux
          inputs'.nvim.packages.default
        ];
      };
    }
  );
}
