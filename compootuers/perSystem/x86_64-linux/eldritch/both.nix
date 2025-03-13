{
  self,
  ...
}:
{
  imports = [
    ./hardware.nix

    self.nixosModules.dwl
  ];
  programs = {
    neovim.enable = true;
  };
  services.openssh.enable = true;
  system.stateVersion = "25.05";
}
