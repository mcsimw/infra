{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        dwl = pkgs.callPackage ./dwl { };
        lucidia = pkgs.callPackage ./lucidia.nix { };
        neovim = inputs.mnw.lib.wrap pkgs (import ./neovim pkgs);
      };
    };
}
