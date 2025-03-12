{
  self,
  packages,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
  environment.systemPackages =
    (with packages; [ google-chrome ])
    ++ (with pkgs; [
      heroic
      mangohud
      obs
    ]);
  programs = {
    steam.enable = true;
  };
}
