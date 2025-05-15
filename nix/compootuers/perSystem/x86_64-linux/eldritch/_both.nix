{
  self,
  self',
  pkgs,
  ...
}:
{
  imports = [
    ./_hardware.nix
    self.modules.nixos.dwl
  ];

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
    torzu_git
    element-desktop
    legcord
  ];

  programs = {
    wireshark.enable = true;
    starship = {
      enable = true;
      settings = pkgs.lib.importTOML (builtins.toPath "${self}/starship/starship.toml");
    };
  };

  networking.useNetworkd = true;

  system.stateVersion = "25.05";
}
