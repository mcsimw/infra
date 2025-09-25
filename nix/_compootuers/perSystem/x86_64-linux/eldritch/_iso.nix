{ pkgs, ... }:
{
  hjem.users.nixos.files.".config/niri/config.kdl".source = ./config.kdl;
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "recovery";
      text = builtins.readFile ./recovery.bash;
    })
  ];
}
