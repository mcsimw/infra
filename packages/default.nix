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
        git = pkgs.callPackage ./git.nix { inherit inputs; };
        dwl = pkgs.callPackage ./dwl { };
        gimp = pkgs.callPackage ./gimp.nix { inherit system; };
        foot = pkgs.callPackage ./foot.nix { inherit inputs inputs'; };
        lucidia = pkgs.callPackage ./lucidia.nix { };
        nvim = pkgs.callPackage ./nvim { };
      };
    };
}
