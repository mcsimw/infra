{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    _:
    {
      config,
      lib,
      ...
    }:
    {
      options.analfabeta.desktop = {
        enable = lib.mkEnableOption "desktop";
        compositors = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          example = [
            "dwl"
            "sway"
          ];
          description = lib.mdDoc ''
            List of Wayland compositors to enable.
          '';
        };
      };
      config = lib.mkIf config.analfabeta.desktop.enable {
        programs.wireshark.enable = true;
        services = {
          blueman.enable = config.hardware.bluetooth.enable;
        };
      };
    }
  );
}
