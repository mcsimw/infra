{
  flake.modules.nixos.users =
    { lib, ... }:
    {
      options.analfabeta.enabledUsers = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "List of users that should be enabled system-wide";
      };
    };
}
