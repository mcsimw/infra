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
        git = pkgs.callPackage ./git.nix { };
        dwl = pkgs.callPackage ./dwl { };
        gimp = pkgs.callPackage ./gimp.nix { inherit system; };
        foot = pkgs.callPackage ./foot.nix { inherit inputs'; };
        lucidia = pkgs.callPackage ./lucidia.nix { };
        #        nvim = pkgs.callPackage ./nvim { };
        neovim = inputs.mnw.lib.wrap pkgs (import ./neovim pkgs);
      };
    };
}
