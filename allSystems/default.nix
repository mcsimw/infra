{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.default
  ];
  users.users.mcsimw = {
    isNormalUser = true;
    password = "1";
    extraGroups = [ "wheel" ];
    uid = 1000;
  };
}
