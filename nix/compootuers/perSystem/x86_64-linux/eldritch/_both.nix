{
  imports = [
    ./_hardware.nix
  ];

  system.stateVersion = "25.11";

  analfabeta.programs = {
    sway.enable = true;
    dwl.enable = true;
  };
}
