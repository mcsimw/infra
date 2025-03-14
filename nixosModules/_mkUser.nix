{
  name,
  shell,
  envShell,
  description,
  uid,
  keys,
  packages,
  hashedPassword,
}:
{
  lib,
  config,
  ...
}:
{
  _file = ./_mkUser.nix;

  environment.shells = [ envShell ];

  users.users.${name} = {
    inherit name;
    inherit description;
    inherit uid;
    inherit shell;
    isNormalUser = true;
    extraGroups =
      [ "wheel" ]
      ++ lib.optional config.virtualisation.libvirtd.enable "libvirtd"
      ++ lib.optional config.networking.networkmanager.enable "networkmanager"
      ++ lib.optional config.programs.light.enable "video"
      ++ lib.optional config.programs.adb.enable "adbusers"
      ++ lib.optional config.virtualisation.docker.enable "docker"
      ++ lib.optional config.services.pipewire.enable "audio";
    openssh.authorizedKeys.keys = keys;
    password = lib.mkDefault "lemon123";
    inherit hashedPassword;
    inherit packages;
  };
}
