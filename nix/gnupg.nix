args@{ preservationHelpers, ... }:
{
  flake.modules.nixos = {
    default =
      { lib, config, ... }:
      {
        imports = [ args.config.flake.modules.nixos.gnupg ];
        programs.gnupg = {
          enable = lib.mkDefault true;
          agent = {
            enable = lib.mkDefault true;
            enableSSHSupport = lib.mkDefault config.services.openssh.enable;
          };
        };
      };
    gnupg =
      {
        pkgs,
        lib,
        config,
        options,
        ...
      }:
      let
        inherit (lib)
          mkDefault
          mkEnableOption
          mkIf
          mkMerge
          mkOption
          optionalAttrs
          types
          ;
        inherit (builtins) attrNames;
        cfg = config.programs.gnupg;
        globalPreservationEnabled = preservationHelpers.isPreservationEnabled options config;
      in
      {
        options.programs.gnupg = {
          enable = mkEnableOption "GnuPG";
          preservation = {
            enable = mkOption {
              type = types.bool;
              default = false;
              description = "Enable preservation for GnuPG (automatically enabled when global preservation is active)";
            };
            path = mkOption {
              type = types.nullOr types.path;
              default = null;
              description = "Path to preserve GnuPG data. If not set, uses config.preservation.defaultPreservationPath.";
            };
          };
        };
        config =
          let
            preservation = cfg.preservation.enable;
            hasPreservation = options ? preservation;
            hasDefaultPathOption = hasPreservation && (options.preservation ? defaultPreservationPath);
            preservationPath =
              if cfg.preservation.path != null then
                cfg.preservation.path
              else
                config.preservation.defaultPreservationPath or null;
            existingUsers = attrNames config.users.users;
            normalUsers = lib.filter (user: config.users.users.${user}.isNormalUser or false) existingUsers;
          in
          mkMerge [
            {
              programs.gnupg.agent.pinentryPackage = mkDefault pkgs.pinentry-curses;
              programs.gnupg.preservation.enable = mkDefault globalPreservationEnabled;
              programs.gnupg.preservation.path = mkDefault (config.preservation.defaultPreservationPath or null);
            }
            (mkIf cfg.enable {
              environment.systemPackages = [ pkgs.gnupg ];
            })
            (mkIf preservation (
              preservationHelpers.mkPreservationChecks {
                serviceName = "programs.gnupg";
                inherit hasPreservation globalPreservationEnabled;
              }
            ))
            (mkIf (cfg.agent.enable && preservation && globalPreservationEnabled) (mkMerge [
              {
                assertions = mkIf hasPreservation [
                  (preservationHelpers.mkPreservationAssertion {
                    optionPath = "programs.gnupg.preservation.path";
                    path = preservationPath;
                    inherit hasDefaultPathOption;
                  })
                ];
              }
              (optionalAttrs hasPreservation (
                preservationHelpers.mkPreservationConfig {
                  path = preservationPath;
                  users = lib.genAttrs normalUsers (_user: {
                    directories = [
                      {
                        directory = ".gnupg";
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
