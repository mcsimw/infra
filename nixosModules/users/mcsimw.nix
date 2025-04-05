{ self' }:
{
  config,
  lib,
  ...
}:
let
  cfg = config.myShit.users.mcsimw.enable;
  dwlEnabled = lib.attrByPath [ "myShit" "dwl" "enable" ] false config;
in
{
  options.myShit.users.mcsimw.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable mcsimw.";
  };

  config = lib.mkIf cfg {
    users.users.mcsimw = {
      description = "Maor Haimovitz";
      isNormalUser = true;
      linger = true;
      extraGroups = [ "wheel" ] ++ (import ./extraGroups.nix { inherit config lib; });
      uid = 1000;
      initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
      packages =
        with self'.packages;
        [
          git
          nvim
        ]
        ++ lib.optionals dwlEnabled [
          foot
        ];
    };
  };
}
