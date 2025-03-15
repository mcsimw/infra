{
  self,
  ...
}:
{
  imports = [
    ./hardware.nix

    self.nixosModules.dwl
  ];
  services.openssh.enable = true;
  system.stateVersion = "25.05";
}
