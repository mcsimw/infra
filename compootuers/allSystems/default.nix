{ inputs, packages, ... }:
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
    #    inputs.vaultix.nixosModules.default
  ];
  users.users.mcsimw = {
    isNormalUser = true;
    password = "1";
    extraGroups = [ "wheel" ];
    uid = 1000;
    packages = with packages; [
      git
    ];
  };
}
