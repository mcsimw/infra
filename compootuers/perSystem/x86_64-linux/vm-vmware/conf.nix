{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
  ];
  programs = {
    neovim.enable = true;
  };
  services.openssh.enable = true;
  system.stateVersion = "25.05";
}
