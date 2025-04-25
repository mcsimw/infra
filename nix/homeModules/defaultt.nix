{ config, ... }:
{
  home-manager.sharedModules = [
    {
      home.stateVersion = config.system.stateVersion;
    }
  ];
}
