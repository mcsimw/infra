{ lib, config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.maor;
    maor =
      { config, ... }:
      {
        users.users = {
          maor = {
            enable = lib.mkDefault false;
            description = "Maor Haimovitz";
            isNormalUser = true;
            initialHashedPassword = "$y$j9T$HmE1eeCA3RdENLRrDyjmC/$QROkFnFmJC18wgrAGu24j8EiCGTEv3N9oC7mN7aj9A8";
          };
          mcsimw = {
            enable = lib.mkDefault false;
            inherit (config.users.users.maor) description initialHashedPassword isNormalUser;
            extraGroups =
              with config;
              [
                "wheel"
                "input"
              ]
              ++ lib.optional virtualisation.libvirtd.enable "libvirtd"
              ++ lib.optional networking.networkmanager.enable "networkmanager"
              #              ++ lib.optional programs.light.enable "video"
              ++ lib.optional virtualisation.docker.enable "docker"
              ++ lib.optional services.home-assistant.enable "dialout"
              ++ lib.optional programs.wireshark.enable "wireshark"
              ++ lib.optional services.pipewire.enable "audio";
          };
        };
      };
  };
}
