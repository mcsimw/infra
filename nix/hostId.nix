{ lib, ... }:
let
  genHostId = hostName: builtins.substring 0 8 <| builtins.hashString "md5" hostName;
in
{
  flake.modules.nixos = {
    default =
      { config, ... }:
      {
        networking.hostId = lib.mkDefault <| genHostId config.networking.hostName;
      };
    iso =
      { config, ... }:
      {
        networking.hostId = lib.mkForce <| genHostId config.networking.hostName;
      };
  };
}
