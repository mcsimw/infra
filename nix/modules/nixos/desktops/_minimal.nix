{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs = {
    foot.enable = true;
    nautilus-open-any-terminal.terminal = lib.mkForce "foot";
  };
  environment = {
    systemPackages = with pkgs; [
      imv
      mako
      zathura
      wmenu
      fuzzel
      pwvucontrol_git
    ];
    variables.QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
  };
  services = {
    blueman.enable = config.hardware.bluetooth.enable;
    xserver.desktopManager.runXdgAutostartIfNone = true;
  };
}
