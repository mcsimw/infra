{
  flake.modules.nixos.analfabeta =
    { lib, config, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        hardware.graphics = {
          enable = lib.mkForce true;
          enable32Bit = lib.mkForce true;
        };
      };
    };
}
