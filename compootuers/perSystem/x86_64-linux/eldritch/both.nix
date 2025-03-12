{
  self,
  inputs',
  packages,
  ...
}:
{
  imports = [
    ./hardware.nix

    self.nixosModules.dwl
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
