{ pkgs, ... }:
{
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    dwl
    foot
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
  ];
}
