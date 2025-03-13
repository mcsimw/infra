{
  self,
  pkgs,
  packages,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
  environment.systemPackages = with pkgs; [
    heroic
    zeroad
    mangohud
    obs-studio
    dolphin-emu
  ];
  programs = {
    steam.enable = true;
  };
  users.users.mcsimw.packages = [ packages.neovim ];
}
