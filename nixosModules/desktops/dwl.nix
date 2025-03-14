{ self, self' }:
_: {
  imports = [
    self.nixosModules.desktop-base
    self.nixosModules.wlroots
  ];
  environment.systemPackages = [ self'.packages.dwl ];
}
