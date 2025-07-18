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
    dwl.enable = true;
    niri.enable = true;
    hyprland.enable = true;
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
    cataclysm-dda
    openmw
    openmw-tes3mp
    torzu_git
    # element-desktop
    emacs-igc-pgtk
    mangohud_git
    dwarf-fortress-full
    pokemmo-installer
  ];

  networking.useNetworkd = true;

  system.stateVersion = "25.11";
}
