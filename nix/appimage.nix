{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.appimage;
    appimage =
      { lib, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.appimage = {
          enable = mkDefault true;
          binfmt = mkDefault true;
        };
      };
  };
}
