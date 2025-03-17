{
  inputs,
  inputs',
  pkgs,
  ...
}:
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    wlr.enable = true;
  };
  environment.systemPackages = with pkgs; [
    wlvncc
    inputs.nixpkgs.legacyPackages.${pkgs.system}.foot # nixpkgs-wayland's foot won't compile for now :(
    inputs'.nyx.legacyPackages.pwvucontrol_git # nixpkgs-wayland's foot won't compile for now :(
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
    imv
    zathura
  ];
}
