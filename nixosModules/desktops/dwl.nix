{ self, ... }:
{ pkgs, ... }:
{
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    self.packages.${pkgs.system}.dwl
    foot
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
  ];
}
