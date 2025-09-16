{
  imports = [
    ./_hardware.nix
  ];

  system.stateVersion = "25.11";

  analfabeta.desktop = {
    enable = true;
    compositors = [
      "sway"
      "dwl"
    ];
  };
}
