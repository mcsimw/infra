{ inputs, ... }:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.nixpkgs-wayland.packages.${system}.foot
    inputs.nixpkgs-wayland.packages.${system}.wlvncc
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
  ];
}
