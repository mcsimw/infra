{ config, preservationHelpers, ... }:
{
  flake.modules.nixos = {
    default =
      { lib, ... }:
      {
        imports = [ config.flake.modules.nixos.openssh ];
        services.openssh.enable = lib.mkDefault true;
      };
    openssh =
      {
        lib,
        config,
        options,
        ...
      }:
      let
        inherit (lib)
          flatten
          genAttrs
          mkDefault
          mkIf
          mkMerge
          mkOption
          optionalAttrs
          types
          ;
        globalPreservationEnabled = preservationHelpers.isPreservationEnabled options config;
      in
      {
        options.services.openssh.preservation = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable preservation for OpenSSH (automatically enabled when global preservation is active)";
          };
          path = mkOption {
            type = types.nullOr types.path;
            default = null;
            description = "Path to preserve SSH keys. If not set, uses config.preservation.defaultPreservationPath.";
          };
        };
        config =
          let
            inherit (config.services) openssh;
            opensshEnabled = openssh.enable;
            preservation = openssh.preservation.enable;
            hasPreservation = options ? preservation;
            hasDefaultPathOption = hasPreservation && (options.preservation ? defaultPreservationPath);
            preservationPath =
              if openssh.preservation.path != null then
                openssh.preservation.path
              else
                config.preservation.defaultPreservationPath or null;
            existingUsers = builtins.attrNames config.users.users;
            normalUsers = lib.filter (user: config.users.users.${user}.isNormalUser or false) existingUsers;
            hostKeyFiles = flatten (
              map (key: [
                {
                  file = key.path;
                  how = "symlink";
                  configureParent = true;
                }
                {
                  file = "${key.path}.pub";
                  how = "symlink";
                  configureParent = true;
                }
              ]) openssh.hostKeys
            );
          in
          mkMerge [
            {
              services.openssh.hostKeys = mkDefault [
                {
                  path = "/etc/ssh/ssh_host_ed25519_key";
                  type = "ed25519";
                }
              ];
              services.openssh.preservation.enable = mkDefault globalPreservationEnabled;
              services.openssh.preservation.path = mkDefault (
                config.preservation.defaultPreservationPath or null
              );
            }
            (mkIf preservation (
              preservationHelpers.mkPreservationChecks {
                serviceName = "services.openssh";
                inherit hasPreservation globalPreservationEnabled;
              }
            ))
            (mkIf (opensshEnabled && preservation && globalPreservationEnabled) (mkMerge [
              {
                assertions = mkIf hasPreservation [
                  (preservationHelpers.mkPreservationAssertion {
                    optionPath = "services.openssh.preservation.path";
                    path = preservationPath;
                    inherit hasDefaultPathOption;
                  })
                ];
              }
              (optionalAttrs hasPreservation (
                preservationHelpers.mkPreservationConfig {
                  path = preservationPath;
                  files = hostKeyFiles;
                  users = genAttrs normalUsers (_user: {
                    directories = [
                      {
                        directory = ".ssh";
                        mode = "0700";
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
