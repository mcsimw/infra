{
  flake.modules.nixos.analfabeta =
    { lib, ... }:
    {
      i18n.extraLocaleSettings.LC_TIME = lib.mkDefault "C.UTF-8";
    };
}


