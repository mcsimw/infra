{
  self',
  inputs',
}:
{ pkgs, inputs, ... }:
{
  environment.systemPackages = [
    self'.packages.dwl
  ];
}
// (import ./base.nix {
  inherit inputs' pkgs;
})
// (import ./wlroots.nix { inherit inputs pkgs; })
