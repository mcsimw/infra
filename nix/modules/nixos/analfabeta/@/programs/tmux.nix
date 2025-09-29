{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self', ... }:
    { lib, ... }:
    {
      programs.tmux = {
        enable = lib.mkDefault true;
        package = lib.mkDefault self'.packages.tmux;
        clock24 = lib.mkDefault true;
      };
    }
  );
}
