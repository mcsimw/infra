{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { pkgs, ... }:
    {
      programs.gnupg.agent = {
        enable = true;
        pinentryPackage = lib.mkDefault pkgs.pinentry-curses;
      };
    };
}
