{
  self,
  pkgs,
  system,
  inputs',
  ...
}:
{
  imports = [
    ./_hardware.nix
    self.modules.nixos.desktop
  ];

  myShit.desktop = {
    dwl.enable = true;
    hyprland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    obs-studio
    signal-desktop-bin
    telegram-desktop
    wireshark
    snort
    kdePackages.kdenlive
    (cataclysm-dda.override {
      tiles = false;
    })
    openmw
    openmw-tes3mp
    torzu_git
    element-desktop
    inputs'.browser-previews.packages.google-chrome-dev
    emacs-igc-pgtk
    mangohud_git
  ];

  programs = {
    wireshark.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-custom
      ];
    };
  };

  networking.useNetworkd = true;

  system.stateVersion = "25.11";
}
