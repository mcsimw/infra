{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    {
      inputs',
    }:
    {
      config,
      options,
      ...
    }:
    let
      cfg = config.analfabeta.programs.prismlauncher;
    in
    {
      options.analfabeta.programs.prismlauncher = {
        enable = lib.mkEnableOption "Install Prism Launcher";
        package = lib.mkOption {
          type = lib.types.package;
          description = "The package for PrismLauncher, can be overridden.";
          inherit (inputs'.prismlauncher.packages) default;
        };
      };
      config = lib.mkIf cfg.enable (
        let
          existingUsers = builtins.attrNames config.users.users;
          normalUsers = lib.filter (user: config.users.users.${user}.isNormalUser or false) existingUsers;
          hasPreservation = options ? preservation;
        in
        lib.mkMerge [
          { environment.systemPackages = [ cfg.package ]; }
          (lib.optionalAttrs hasPreservation {
            preservation.preserveAt."/persist" = {
              users = lib.genAttrs normalUsers (_user: {
                directories = [ ".local/share/PrismLauncher" ];
              });
            };
          })
        ]
      );
    }
  );
}
