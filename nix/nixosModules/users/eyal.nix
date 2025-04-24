{ self' }:
{
  config,
  lib,
  ...
}:
{
  options.myShit.users.eyal.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable eyal.";
  };

  config = lib.mkIf cfg {
    users.users.eyal = {
      description = "Eyal Haimovitz";
      isNormalUser = true;
      linger = true;
      extraGroups = import ./extraGroups.nix { inherit config lib; };
      uid = 1001;
      initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
    };
  };
}
