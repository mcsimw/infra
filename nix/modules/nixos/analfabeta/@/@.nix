{
  flake.modules.nixos.analfabeta =
    { lib, ... }:
    {
      users.mutableUsers = lib.mkForce false;
      i18n.extraLocaleSettings.LC_TIME = lib.mkDefault "C.UTF-8";
    };
}
