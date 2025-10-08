{ lib, inputs, ... }:

{
  flake.modules.nixos.analfabeta =
    { config, pkgs, ... }:
    let
      chaotic = inputs.chaotic.legacyPackages.${pkgs.system};
    in
    {
      hardware.graphics = {
        enable = lib.mkForce config.programs.niri.enable;
        enable32Bit = lib.mkForce config.programs.niri.enable;
        package = lib.mkForce chaotic.mesa_git;
        package32 = lib.mkForce chaotic.mesa32_git;
      };
    };
}
