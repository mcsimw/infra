{ lib, ... }:
{
  flake.modules.nixos.bluetooth.hardware.bluetooth.settings.General = {
    Experimental = true;
    Enable = lib.mkDefault "Source,Sink,Media,Socket";
  };
}
