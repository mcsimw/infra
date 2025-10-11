{
  config,
  self',
  inputs,
  ...
}:
let
  niri = config.programs.niri.enable;
in
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    ./bootloader.nix
    inputs.emoji-picker-nix.nixosModules.default
  ];

  programs = {
    steam.enable = niri;
    prismlauncher.enable = niri;
    emoji-fuzzel = {
      enable = true;
      src = "unicode";
    };
    emoji-fzf = {
      enable = true;
      src = "unicode";
    };
  };

  environment.systemPackages = [
    self'.packages.ciscoPacketTracer8
    self'.packages.tofi
  ];

}
