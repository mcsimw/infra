{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
    #    inputs.vaultix.nixosModules.default

    inputs.userModules.git
  ];
  users.users.mcsimw = {
    isNormalUser = true;
    password = "1";
    extraGroups = [ "wheel" ];
    uid = 1000;
  };
}
