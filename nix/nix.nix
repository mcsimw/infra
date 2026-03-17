{ config, ... }:
let
  inherit (config) sources;
in
{
  nixpkgs.overlays = [
    #    (import config.sources.nix).overlays.default
  ];
  flake.modules.nixos = {
    default =
      { pkgs, lib, ... }:
      {
        imports = [ config.flake.modules.nixos.nix ];
        environment = {
          etc.nixpkgs.source = pkgs.path;
          sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
        };
        nix = {
          registry = lib.mkForce {
            nixpkgs.to = {
              type = "github";
              owner = "NixOS";
              repo = "nixpkgs";
              ref = sources.nixpkgs.revision;
            };
          };
          nixPath = [ "nixpkgs=/etc/nixpkgs" ];
          settings.flake-registry = "/etc/nix/registry.json";
        };
      };
    nix =
      { config, lib, ... }:
      {
        nix = {
          channel.enable = lib.mkForce false;
          settings = {
            auto-allocate-uids = true;
            trusted-users = [ "@wheel" ];
            allowed-users = lib.mapAttrsToList (_: u: u.name) (
              lib.filterAttrs (_: user: user.isNormalUser) config.users.users
            );
            warn-dirty = false;
            keep-derivations = true;
            keep-outputs = true;
            accept-flake-config = false;
            allow-import-from-derivation = false;
            builders-use-substitutes = true;
            use-xdg-base-directories = true;
            use-cgroups = true;
            log-lines = 30;
            keep-going = true;
            connect-timeout = 5;
            sandbox = true;
            http-connections = 0;
            max-substitution-jobs = 128;
            system-features = [ "uid-range" ];
            extra-experimental-features = [
              "nix-command"
              "flakes"
              "cgroups"
              "auto-allocate-uids"
              "fetch-closure"
              "dynamic-derivations"
              "pipe-operators"
              "recursive-nix"
            ];
          };
        };
      };
  };
}
