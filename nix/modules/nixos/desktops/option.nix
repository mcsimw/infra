{
  flake.modules.nixos.desktop =
    { lib, ... }:
    {
      options.analfabeta.desktop = lib.mkOption {
        type = lib.types.enum [ "niri" ];
        description = "Desktop Environment";
        default = "niri";
      };
    };
}
