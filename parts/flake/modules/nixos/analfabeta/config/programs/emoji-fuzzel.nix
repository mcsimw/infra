{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      programs.emoji-fuzzel = {
        inherit (config.programs.niri) enable;
        src = "unicode";
      };
    };
}
