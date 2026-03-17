{ config, preservationHelpers, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.steam;
    steam =
      {
        config,
        lib,
        options,
        ...
      }:
      let
        inherit (lib)
          mkOption
          types
          mkIf
          mkMerge
          mkDefault
          genAttrs
          optionalAttrs
          ;
        globalPreservationEnabled = preservationHelpers.isPreservationEnabled options config;
      in
      {
        options.programs.steam.preservation = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable preservation for Steam (automatically enabled when global preservation is active)";
          };
          path = mkOption {
            type = types.nullOr types.path;
            default = null;
            description = "Path to steam preservation dir. If not set, uses config.preservation.defaultPreservationPath.";
          };
        };
        config =
          let
            inherit (config.programs) steam;
            steamEnabled = steam.enable or false;
            preservation = steam.preservation.enable;
            hasPreservation = options ? preservation;
            hasDefaultPathOption = hasPreservation && (options.preservation ? defaultPreservationPath);
            preservationPath =
              if steam.preservation.path != null then
                steam.preservation.path
              else
                config.preservation.defaultPreservationPath or null;
            existingUsers = builtins.attrNames config.users.users;
            normalUsers = lib.filter (user: config.users.users.${user}.isNormalUser or false) existingUsers;
          in
          mkMerge [
            {
              programs.steam.preservation.enable = mkDefault globalPreservationEnabled;
              programs.steam.preservation.path = mkDefault (config.preservation.defaultPreservationPath or null);
            }
            (mkIf preservation (
              preservationHelpers.mkPreservationChecks {
                serviceName = "programs.steam";
                inherit hasPreservation globalPreservationEnabled;
              }
            ))
            (mkIf (steamEnabled && preservation && globalPreservationEnabled) (mkMerge [
              {
                assertions = mkIf hasPreservation [
                  (preservationHelpers.mkPreservationAssertion {
                    optionPath = "programs.steam.preservation.path";
                    path = preservationPath;
                    inherit hasDefaultPathOption;
                  })
                ];
              }
              (optionalAttrs hasPreservation (
                preservationHelpers.mkPreservationConfig {
                  path = preservationPath;
                  users = genAttrs normalUsers (_user: {
                    directories = [
                      {
                        directory = ".steam";
                        mode = "0755";
                      }
                      {
                        directory = ".local/share/Steam";
                        mode = "0755";
                      }
                    ];
                  });
                }
              ))
            ]))
          ];
      };
  };
}
