{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.nixpkgs.legacyPackages.${pkgs.system}.wlvncc # nixpkgs-wayland's vlvncc won't compile for now :(
    inputs.nixpkgs.legacyPackages.${pkgs.system}.foot # nixpkgs-wayland's foot won't compile for now :(
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
    imv
    zathura
  ];
}
