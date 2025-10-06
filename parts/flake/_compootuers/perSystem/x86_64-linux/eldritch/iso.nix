{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "recovery";
      text = builtins.readFile ./recovery.bash;
    })
  ];

}
