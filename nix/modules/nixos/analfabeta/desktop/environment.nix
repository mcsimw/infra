{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs', self', ... }:
    {
      config,
      pkgs,
      ...
    }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        environment.systemPackages = [
          inputs'.xwayland-satellite.packages.default
          inputs'.browser-previews.packages.google-chrome-dev
          self'.packages.mpv
        ]
        ++ (with pkgs; [
          (lib.mkIf config.services.pipewire.enable pwvucontrol_git)
          (lib.mkIf config.programs.wireshark.enable wireshark)
          mako
          wmenu
          adwaita-icon-theme
          zathura
          imv
          wl-clipboard-rs
          ani-cli
        ]);
      };
    }
  );
}
