{ pkgs, config, ... }:
{
  programs = {
    foot.enable = true;
  };
  environment = {
    systemPackages = with pkgs; [
      imv
      mako
      zathura
      wmenu
      pwvucontrol_git
    ];
    variables.QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
  };
  services = {
    blueman.enable = config.hardware.bluetooth.enable;
    xserver.desktopManager.runXdgAutostartIfNone = true;
  };
}
