{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    {
      packages = {
        dwl = pkgs.callPackage ./dwl { };
        blink-cmp = pkgs.callPackage ./blink-cmp.nix { };
        gimp = pkgs.callPackage ./gimp.nix { inherit system; };
        lucidia = pkgs.callPackage ./lucidia.nix { };
        neovim = inputs.mnw.lib.wrap pkgs (import ./neovim pkgs);
      };
    };
}
