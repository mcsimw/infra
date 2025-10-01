{
  flake.modules.nixos.analfabeta =
    {
      lib,
      config,
      options,
      ...
    }:
    {
      config = lib.mkMerge [
        (lib.mkIf config.services.openssh.enable (
          let
            existingUsers = builtins.attrNames config.users.users;
            normalUsers = lib.filter (user: config.users.users.${user}.isNormalUser or false) existingUsers;
            hasPreservation = options ? preservation;
          in
          lib.optionalAttrs hasPreservation {
            preservation.preserveAt."/persist" = {
              files = [
                {
                  file = "/etc/ssh/ssh_host_ed25519_key";
                  how = "symlink";
                  configureParent = true;
                }
                {
                  file = "/etc/ssh/ssh_host_ed25519_key.pub";
                  how = "symlink";
                  configureParent = true;
                }
              ];
              users = lib.genAttrs normalUsers (_user: {
                directories = [
                  {
                    directory = ".ssh";
                    mode = "0700";
                  }
                ];
              });
            };
          }
        ))
        {
          services.openssh.hostKeys = [
            {
              path = "/etc/ssh/ssh_host_ed25519_key";
              type = "ed25519";
            }
          ];
        }
      ];
    };
}
