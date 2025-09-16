{
  flake.modules.nixos.infra =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        services = {
          xserver.desktopManager.runXdgAutostartIfNone = true;
          graphical-desktop.enable = lib.mkForce true;
          dbus.packages = [ pkgs.dconf ];
        };
        hardware.graphics = {
          enable = lib.mkForce true;
          enable32Bit = lib.mkForce true;
        };
      };
    };

}
