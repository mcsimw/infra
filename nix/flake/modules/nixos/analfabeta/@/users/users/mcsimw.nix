{
  moduleWithSystem,
  lib,
  self,
  ...
}:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self' }:
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
        ++ (import "${self}/nix/flake/modules/nixos/analfabeta/@/users/_extraGroups.nix" {
          inherit config lib;
        });
        uid = lib.mkDefault 1000;
        initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
        packages = with self'.packages; [
          git
          nvim
        ];
      };
    }
  );
}
