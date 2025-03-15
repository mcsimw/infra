{ self' }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myShit.users.mcsimw.enable;
  dwlEnabled = lib.attrByPath ["myShit" "dwl" "enable"] false config;
in
{
  options.myShit.users.mcsimw.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable mcsimw.";
  };

  config = lib.mkIf cfg {
    environment.shells = [ pkgs.nushell ];
    users.users.mcsimw = {
      description = "Maor Haimovitz";
      isNormalUser = true;
      extraGroups = [ "wheel" ] ++ (import ./extraGroups.nix { inherit config lib; });
      uid = 1000;
      password = "1";
      packages = with self'.packages; [
        git
        nushell
        neovim
      ] ++ lib.optionals dwlEnabled [
        google-chrome
	foot
      ];
      shell = "/etc/profiles/per-user/mcsimw/bin/nu";
    };
  };
}
