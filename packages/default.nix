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
        gimp = pkgs.callPackage ./gimp.nix { inherit system; };
        foot = pkgs.callPackage ./foot.nix { inherit inputs inputs'; };
      };
    };
}
