{ self, lib, ... }:
{
  flake.modules.nixos.lanzaboote = lib.modules.importApply (
    { self, ... }:
    { lib, pkgs, ... }:
    {
      imports = [
        self.inputs.lanzaboote.nixosModules.lanzaboote
      ];

      environment.systemPackages = with pkgs; [
        sbctl
        efibootmgr
      ];

      boot = {
        loader.efi.canTouchEfiVariables = lib.mkForce false;
        loader.systemd-boot.enable = lib.mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      };
    }
  ) { inherit self; };
}
