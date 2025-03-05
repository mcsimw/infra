{ pkgs, ... }:
{
  users.users.mcsimw = {
    isNormalUser = true;
    password = "1";
    extraGroups = [ "wheel" ];
  };
  environment.systemPackages = with pkgs; [
    wget
  ];
  programs = {
    steam.enable = true;
    neovim.enable = true;
  };
  services.openssh.enable = true;
  system.stateVersion = "25.05";
  boot.initrd.systemd.enable = true;
}
