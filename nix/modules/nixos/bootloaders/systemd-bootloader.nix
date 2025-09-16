{
  flake.modules.nixos.infra =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.analfabeta.bootloader = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "whether to enable bootloader.";
        };
      };
      config = lib.mkIf config.analfabeta.bootloader.enable {
        boot.loader = {
          systemd-boot = {
            enable = lib.mkDefault true;
            editor = lib.mkForce false;
          };
          efi.canTouchEfiVariables = lib.mkForce true;
        };
        environment.systemPackages = [ pkgs.efibootmgr ];
      };
    };
}
