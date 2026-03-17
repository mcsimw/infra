{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.locale;
    locale =
      { lib, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        i18n = {
          defaultLocale = lib.mkDefault "en_CA.UTF-8";
          extraLocaleSettings.LC_TIME = lib.mkDefault "C.UTF-8";
        };
        time.timeZone = mkDefault "Canada/Eastern";
      };
  };
}
