{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs', self', ... }:
    {
      config,
      lib,
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
          mako
          wmenu
          (lib.mkIf config.services.pipewire.enable pwvucontrol_git)
          adwaita-icon-theme
          zathura
          imv
          wl-clipboard-rs
          (lib.mkIf config.programs.wireshark.enable wireshark)
        ]);
      };
    }
  );
}
