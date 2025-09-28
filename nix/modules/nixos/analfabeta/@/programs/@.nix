{
  flake.modules.nixos.analfabeta = { lib, ... }: {
  programs = {
    wireshark.enable = lib.mkDefault true;
    command-not-found.enable = lib.mkForce false;
    fuse.userAllowOther = true;
    nano.enable = lib.mkForce false;
  };
  };
}

