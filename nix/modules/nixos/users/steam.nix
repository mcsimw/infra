{
  flake.modules.nixos.users =
    {
      lib,
      config,
      ...
    }:
    let
      cfg = config.analfabeta.programs.steam;
    in
    {
      options.analfabeta.programs.steam = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = lib.hasAttrByPath [ "analfabeta" "desktop" ] config;
          description = "Enable Steam (automatically enabled with desktop)";
        };
        users = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = config.analfabeta.enabledUsers or [ ];
          description = "Users to configure Steam for";
        };
      };
      config = lib.mkIf cfg.enable (lib.mkMerge [
        {
          programs.steam.enable = true;
        }
        (lib.mkIf (
          lib.hasAttrByPath [ "preservation" "enable" ] config &&
          config.preservation.enable
        ) {
          preservation.preserveAt."/persist" = lib.mkMerge (
            map (user: {
              users.${user}.directories = [
                ".local/share/Steam"
                ".steam"
              ];
            }) cfg.users
          );
        })
      ]);
    };
}
