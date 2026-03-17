{ config, ... }:
let
  inherit (config) sources;
in
{
  flake.modules.nixos.default =
    { pkgs, ... }:
    let
      stasis-module =
        (import sources.flake-compat { src = sources.stasis; }).defaultNix.nixosModules.default;
    in
    {
      imports = [ stasis-module ];
      environment.systemPackages = [ pkgs.pulseaudioFull ];
      services.stasis = {
        enable = true;
        extraConfig = ''
          default:
            monitor_media true
            ignore_remote_media true
            respect_idle_inhibitors true

            dpms:
              timeout 120
              command "niri msg action power-off-monitors"
              resume_command "niri msg action power-on-monitors"
            end
          end
        '';
      };
    };
}
