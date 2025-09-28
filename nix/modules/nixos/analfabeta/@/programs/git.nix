{
  flake.modules.nixos.analfabeta = { lib, ... }: {
    programs.git = {
      enable = lib.mkForce true;
      lfs.enable = lib.mkDefault true;
    };
  };
}

