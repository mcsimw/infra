{
  lib,
  pkgs,
  ...
}:
{
  hardware = {
    cpu.x86.msr.enable = true;
    graphics = {
      package = lib.mkForce pkgs.mesa_git;
      package32 = lib.mkForce pkgs.mesa32_git;
    };
  };

}
