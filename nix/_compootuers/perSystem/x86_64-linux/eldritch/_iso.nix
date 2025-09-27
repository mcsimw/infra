{ pkgs, ... }:
{
  #  analfabeta.desktop.users.nixos = ./config.kdl
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "recovery";
      text = builtins.readFile ./recovery.bash;
    })
  ];
}
