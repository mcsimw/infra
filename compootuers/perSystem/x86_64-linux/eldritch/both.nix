{
  self,
  pkgs,
  inputs',
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

    virt-viewer
    spice-protocol
    spice-gtk
    win-virtio
    win-spice
    adwaita-icon-theme

  ];
  programs = {
    hyprland = {
      enable = true;
      package = inputs'.hyprland.packages.hyprland;
      portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
    };
    wireshark.enable = true;
    virt-manager.enable = true;
    steam.enable = true;
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;

  system.stateVersion = "25.05";
}
