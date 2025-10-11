{ moduleWithSystem, lib, ... }:

{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { pkgs }:
    { config, ... }:
    {
      hardware.graphics = {
        enable = lib.mkForce config.programs.niri.enable;
        enable32Bit = lib.mkForce config.programs.niri.enable;
        package = lib.mkForce pkgs.mesa_git;
        package32 = lib.mkForce pkgs.mesa32_git;
      };
    }
  );
}
