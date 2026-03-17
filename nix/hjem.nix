{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.hjem;
    hjem =
      { pkgs, ... }:
      let
        hjem = import config.sources.hjem {
          inherit pkgs;
          smfh = pkgs.callPackage (import "${config.sources.smfh}/package.nix") { };
        };
      in
      {
        imports = [ hjem.nixosModules.default ];
        hjem = {
          linker = hjem.packages.smfh;
          clobberByDefault = true;
          extraModules =
            "${config.sources.hjem-rum}/modules/collection" |> pkgs.lib.filesystem.listFilesRecursive;
        };
      };
  };
}
