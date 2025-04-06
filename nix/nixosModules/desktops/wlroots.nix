{
  inputs,
  pkgs,
  config,
  ...
}:
{
  services.blueman.enable = config.hardware.bluetooth.enable;

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

    wlr.enable = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.nixpkgs.legacyPackages.${pkgs.system}.foot # nixpkgs-wayland's foot won't compile for now :(
    inputs.nixpkgs.legacyPackages.${pkgs.system}.wlvncc # nixpkgs-wayland's wlvncc won't compile for now :(
    pwvucontrol_git
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
    imv
    zathura
    swaybg
  ];
}
