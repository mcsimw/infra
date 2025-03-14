{
  packages,
  pkgs,
  self,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
    (import ../../../../nixosModules/_mkUser.nix {
      name = "lemon";
      uid = 1003;
      shell = packages.nushell;
      envShell = pkgs.nushell;
      description = "lemon man";
      keys = [ ]; # No SSH keys
      packages = [ pkgs.fish ]; # User gets `fish` shell as a package
      hashedPassword = null;
    })
  ];
  users.users.mcsimw.packages = with packages; [
    neovim
    foot
  ];
}
