{
  system,
  self,
  ...
}:
{
  imports = [
    ./hardware.nix
    self.nixosModules.dwl
  ];
  system.stateVersion = "25.05";
}
