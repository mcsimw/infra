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
  };

  environment.systemPackages = with pkgs; [
    obs-studio
    kdePackages.kdenlive
    emacs-igc-pgtk
  ];

  networking = {
    useNetworkd = true;
    wireless.iwd.enable = true;
  };

  system.stateVersion = "25.11";
}
