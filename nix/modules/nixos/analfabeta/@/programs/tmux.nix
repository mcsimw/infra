{
  flake.modules.nixos.analfabeta = { lib, ... }: {
    programs.tmux = {
      enable = lib.mkDefault true;
      clock24 = lib.mkDefault true;
    };
  };
}
