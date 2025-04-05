{
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix
    self.nixosModules.dwl
  ];
  environment.systemPackages = with pkgs; [
    obs-studio
    libreoffice-fresh
    signal-desktop
    telegram-desktop_git
    heroic
    wireshark
  ];
  programs = {
    wireshark.enable = true;
    virt-manager.enable = true;
  };
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  system.stateVersion = "25.05";
}
