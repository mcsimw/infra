{
  flake.modules.nixos.analfabeta =
    { lib, ... }:
    {
      security = {
        polkit.enable = lib.mkDefault true;
        rtkit.enable = lib.mkDefault true;
      };
    };
}
