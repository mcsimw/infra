{ inputs, ... }:
{
  perSystem =
    { pkgs, inputs', ... }:
    {
      packages = {
        git = pkgs.callPackage ./git.nix { inherit inputs; };
        foot = pkgs.callPackage ./foot.nix { inherit inputs inputs'; };
      };
    };
}
