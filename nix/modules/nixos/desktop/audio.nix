{
  flake.modules.nixos.infra =
    { lib, config, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        security.rtkit.enable = true;
        services.pipewire = {
          enable = lib.mkDefault true;
          jack.enable = lib.mkDefault true;
          alsa = {
            enable = lib.mkDefault true;
            support32Bit = lib.mkDefault true;
          };
          pulse.enable = lib.mkDefault true;
        };
      };
    };
}
