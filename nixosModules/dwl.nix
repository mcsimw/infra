{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  environment.systemPackages = with pkgs; [
    dwl
    foot
    wl-clipboard-rs
    wmenu
    sway-contrib.grimshot
    slurp
  ];
}
