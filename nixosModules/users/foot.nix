{ inputs, ... }:
{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.lemon.foot.users = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "Enable foot wrapper";
          config = lib.mkOption {
            type = lib.types.path;
            default = null;
            description = "Path to the foot configuration file";
          };
        };
      }
    );
    default = { };
    description = ''
      lemon.foot.users.<name> for per-user foot config
    '';
  };

  config.users.users = lib.genAttrs (builtins.attrNames config.lemon.foot.users) (
    userName:
    lib.mkIf config.lemon.foot.users.${userName}.enable {
      packages = [
        (inputs.wrapper-manager.lib.build {
          inherit pkgs;
          modules = [
            {
              wrappers."${userName}-foot" = {
                basePackage = pkgs.foot;
                flags = [ "--config=${config.lemon.foot.users.${userName}.config}" ];
              };
            }
          ];
        })
      ];
    }
  );
}
