{
  self,
  pkgs,
  system,
  ...
}:
{
  imports = [
    ./_hardware.nix
    self.modules.nixos.desktop
  ];

  programs = {
    wireshark.enable = true;
    niri.enable = true;
    dwl.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-custom
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    obs-studio
    kdePackages.kdenlive
    (cataclysm-dda.override { tiles = false; })
    openmw
    openmw-tes3mp
    torzu_git
    element-desktop
    emacs-igc-pgtk
    mangohud_git
  ];

  networking.useNetworkd = true;

  system.stateVersion = "25.11";
}
