{
  self,
  pkgs,
  inputs',
  system,
  packages,
  ...
}:
{
  imports = [
    ./hardware.nix

    self.nixosModules.dwl
  ];
  environment.systemPackages = with pkgs; [
    wget
    qutebrowser
  ];
  programs = {
    neovim.enable = true;
    firefox = {
      enable = true;
      package = inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
    };
  };
  services.openssh.enable = true;
  system.stateVersion = "25.05";
}
