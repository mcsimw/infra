{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { pkgs }:
    {
      hardware.graphics = {
        package = lib.mkForce pkgs.mesa_git;
        package32 = lib.mkForce pkgs.mesa32_git;
      };
    }
  );
}
