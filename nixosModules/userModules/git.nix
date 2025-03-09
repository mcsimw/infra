{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  options.lemon.git.users = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "Enable Git wrapper";
          config = lib.mkOption {
            type = lib.types.path;
            default = null;
          };
        };
      }
    );
    default = { };
    description = ''
      lemon.git.users.<name> for per-user Git config
    '';
  };

  config.users.users = lib.genAttrs (builtins.attrNames config.lemon.git.users) (
    userName:
    lib.mkIf config.lemon.git.users.${userName}.enable {
      packages = [
        (inputs.wrapper-manager.lib.build {
          inherit pkgs;
          modules = [
            {
              wrappers."${userName}-git" = {
                basePackage = pkgs.gitFull;
                extraPackages = [
                  pkgs.git-extras
                  pkgs.gitFull
                ];
                env.GIT_CONFIG_GLOBAL.value = config.lemon.git.users.${userName}.config;
              };
            }
          ];
        })
      ];
    }
  );
}
