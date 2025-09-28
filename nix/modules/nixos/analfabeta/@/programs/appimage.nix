{
  flake.modules.nixos.analfabeta = { lib, ... }: {
    programs.appimage = {
      enable = lib.mkDefault true;
      binfmt = lib.mkDefault true;
    };
  };
}
