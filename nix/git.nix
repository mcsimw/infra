{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.git;
    git =
      { lib, ... }:
      {
        programs.git.enable = lib.mkForce true;
      };
  };
}
