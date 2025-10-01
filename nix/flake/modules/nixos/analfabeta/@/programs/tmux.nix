{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self' }:
    {
      programs.tmux = {
        enable = lib.mkDefault true;
        package = lib.mkDefault self'.packages.tmux;
        clock24 = lib.mkDefault true;
      };
    }
  );
}
