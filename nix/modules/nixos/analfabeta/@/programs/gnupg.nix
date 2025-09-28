{
  flake.modules.nixos.analfabeta =
    { lib, pkgs, ... }:
    {
      programs.gnupg.agent = {
        enable = true;
        pinentryPackage = lib.mkDefault pkgs.pinentry-curses;
      };
    };
}
