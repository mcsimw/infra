{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      inputs',
      system,
      ...
    }:
    {
      packages = {
        dwl = pkgs.callPackage ./dwl { };
        gimp = pkgs.callPackage ./gimp.nix { inherit system; };
        lucidia = pkgs.callPackage ./lucidia.nix { };
        #        nvim = pkgs.callPackage ./nvim { };
        neovim = inputs.mnw.lib.wrap pkgs (import ./neovim pkgs);
      };
    };
}
