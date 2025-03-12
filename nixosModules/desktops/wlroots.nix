{ inputs, ... }:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.nixpkgs-wayland.packages.${pkgs.system}.foot
    inputs.nixpkgs-wayland.packages.${pkgs.system}.wlvncc
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
  ];
}
