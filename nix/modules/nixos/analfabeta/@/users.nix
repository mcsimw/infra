{
  flake.modules.nixos.analfabeta =
    { lib, ... }:
    {
      users.mutableUsers = lib.mkForce false;
    };
}


