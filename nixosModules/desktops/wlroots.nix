{ inputs, ... }:
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.nixpkgs-wayland.packages.${pkgs.system}.wlvncc
    inputs.nixpkgs.legacyPackages.${pkgs.system}.foot # nixpkgs-wayland's foot won't compile for now :(
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
  ];
}
