{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "recovery";
      text = builtins.readFile ./recovery.bash;
    })
  ];
  analfabeta.desktop.users.nixos = ./config.kdl;

}
