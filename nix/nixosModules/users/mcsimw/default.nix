{ self' }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myShit.users.mcsimw.enable;
  dwlEnabled = lib.attrByPath [ "myShit" "dwl" "enable" ] false config;
  dwl = pkgs.writeShellScriptBin "dwl" ''
    ${self'.packages.dwl}/bin/dwl -s "
      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP=dwl;
      systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE;
      systemctl --user start yes.target;
    "
  '';
in
{
  options.myShit.users.mcsimw.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable mcsimw.";
  };

  config = lib.mkIf cfg {
    systemd.user.targets.yes = {
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
    };
    users.users.mcsimw = {
      description = "Maor Haimovitz";
      isNormalUser = true;
      linger = true;
      extraGroups = [ "wheel" ] ++ (import ../extraGroups.nix { inherit config lib; });
      uid = 1000;
      initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
      packages =
        [
          self'.packages.git
          self'.packages.neovim
        ]
        ++ lib.optionals dwlEnabled [
          self'.packages.foot
          dwl
        ];
    };
  };
}
