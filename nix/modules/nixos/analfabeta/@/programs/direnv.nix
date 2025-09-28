{
  flake.modules.nixos.analfabeta = { lib, ... }: {
    programs.direnv = {
      enable = lib.mkDefault true;
      silent = lib.mkDefault true;
    };
  };
}

