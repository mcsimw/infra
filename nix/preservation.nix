{ config, lib, ... }:
let
  preservationHelpers = {
    mkPreservationAssertion =
      {
        optionPath,
        path,
        hasDefaultPathOption,
      }:
      {
        assertion = path != null;
        message =
          if hasDefaultPathOption then
            "${optionPath} must be set. Either set it explicitly or set preservation.defaultPreservationPath globally."
          else
            "${optionPath} must be set explicitly.";
      };
    mkPreservationConfig =
      {
        path,
        files ? [ ],
        directories ? [ ],
        users ? { },
      }:
      {
        preservation.preserveAt.${path} = {
          inherit files users directories;
        };
      };
    isPreservationEnabled =
      options: config:
      (options ? preservation)
      && (options.preservation ? enable)
      && (config.preservation.enable or false);
    mkPreservationChecks =
      {
        serviceName,
        hasPreservation,
        globalPreservationEnabled,
      }:
      {
        assertions = [
          {
            assertion = hasPreservation;
            message = ''
              ${serviceName}.preservation.enable is set to true, but the preservation module is not available.
              To use preservation for ${serviceName}, you need to:
                1. Import the preservation module in your configuration
                2. Enable it with: preservation.enable = true;
            '';
          }
        ];
        warnings = lib.mkIf (hasPreservation && !globalPreservationEnabled) [
          "${serviceName}.preservation.enable is true, but preservation.enable is false. ${serviceName} preservation will not be active."
        ];
      };
  };
in
{
  _module.args = { inherit preservationHelpers; };
  flake.modules.nixos = {
    default = config.flake.modules.nixos.preservation;
    preservation = {
      imports = [ (import "${config.sources.preservation}/module.nix") ];
      options.preservation.defaultPreservationPath = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "Default path for preservation. Other modules will use this if set.";
        example = "/persist";
      };
      config.preservation.preserveAt."/persist" = {
        directories = [
          "/var/log"
          "/var/lib/systemd/coredump"
        ];
        files = [
          {
            file = "/var/lib/systemd/random-seed";
            how = "symlink";
            inInitrd = true;
            configureParent = true;
          }
        ];
      };
    };
  };
}
