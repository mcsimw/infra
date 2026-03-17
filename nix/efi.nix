{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.efi;
    efi =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        config = lib.mkIf config.boot.loader.systemd-boot.enable {
          environment.systemPackages = [ pkgs.efibootmgr ];
        };
      };
  };
}
