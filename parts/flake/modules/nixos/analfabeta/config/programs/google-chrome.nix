{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      programs.google-chrome.enable = config.programs.niri.enable;
    };
}
