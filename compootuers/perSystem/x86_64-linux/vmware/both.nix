{
  system,
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix
    self.nixosModules.dwl
  ];
  system.stateVersion = "25.05";
  environment.systemPackages = with pkgs; [
    libreoffice
    dwarf-fortress
    nushell
  ];
}
