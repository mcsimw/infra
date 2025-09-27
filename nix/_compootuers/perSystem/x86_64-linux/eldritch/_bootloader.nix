{ pkgs, ... }:
{
  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
    };
    efi.canTouchEfiVariables = true;
  };
  analfabeta.desktop.enable = true;
  environment.systemPackages = [ pkgs.efibootmgr ];

}
