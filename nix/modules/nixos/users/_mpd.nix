{
  flake.modules.nixos.users =
    {
      lib,
      config,
      pkgs,
      self,
      ...
    }:
    let
      cfg = config.analfabeta.programs.mpd;
      hasHjem = lib.hasAttrByPath [ "hjem" ] config;
    in
    {
      options.analfabeta.programs.mpd = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = lib.hasAttrByPath [ "analfabeta" "desktop" ] config;
          description = "Enable MPD (automatically enabled with desktop)";
        };
        users = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = lib.attrByPath [ "analfabeta" "enabledUsers" ] [ ] config;
          description = "Users to configure MPD for";
        };
      };

      config = lib.mkIf cfg.enable (
        if !hasHjem then
          throw "The MPD part of the users module requires the hjem module to be imported."
        else
          {
            users.users = lib.genAttrs cfg.users (_: {
              packages = [ pkgs.mpd ];
            });

            hjem.users = lib.genAttrs cfg.users (_: {
              files.".config/mpd/mpd.conf".source = "${self}/dotfiles/mpd.conf";
            });
          }
      );
    };
}
