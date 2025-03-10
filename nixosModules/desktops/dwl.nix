{ self, ... }:
{ pkgs, ... }:
{
  imports = [
    self.nixosModules.desktop-base
    self.nixosModules.wlroots
  ];
  environment.systemPackages = [ self.packages.${pkgs.system}.dwl ];
}
