{
  flake.modules.nixos.analfabeta =
    { lib, config, ... }:
    {
      nix = {
        channel.enable = false;
        settings = {
          auto-allocate-uids = true;
          trusted-users = [ "@wheel" ];
          allowed-users = lib.mapAttrsToList (_: u: u.name) (
            lib.filterAttrs (_: user: user.isNormalUser) config.users.users
          );
          "flake-registry" = "/etc/nix/registry.json";
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
}
