{
  flake.modules.nixos.analfabeta =
    { lib, ... }:
    {
      options.analfabeta.desktop.enable = lib.mkEnableOption "niri";
    };
}
