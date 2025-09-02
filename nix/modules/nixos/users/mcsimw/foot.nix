{ moduleWithSystem, ... }:
{
  flake.modules.nixos.users = moduleWithSystem (
    _:
    {
      config,
      lib,
      pkgs,
      self,
      ...
    }:
    {
      config = (lib.mkIf (config.analfabeta.users.mcsimw.enable && config.analfabeta.desktop == "niri")) (
        lib.mkMerge [
          { users.users.mcsimw.packages = [ pkgs.foot ]; }
          (lib.mkIf (lib.hasAttrByPath [ "hjem" ] config) {
            hjem.users.mcsimw.files.".config/foot/foot.ini".source = "${self}/dotfiles/foot/foot.ini";
          })
        ]
      );
    }
  );
}
