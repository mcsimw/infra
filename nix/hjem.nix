{ config, inputs, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.hjem;
    hjem =
      { pkgs, ... }:
      let
        hjem = import inputs.hjem {
          inherit pkgs;
          smfh = pkgs.callPackage (import "${inputs.smfh}/package.nix") { };
        };
      in
      {
        imports = [ hjem.nixosModules.default ];
        hjem = {
          linker = hjem.packages.smfh;
          clobberByDefault = true;
          extraModules = "${inputs.hjem-rum}/modules/collection" |> pkgs.lib.filesystem.listFilesRecursive;
        };
      };
  };
}
