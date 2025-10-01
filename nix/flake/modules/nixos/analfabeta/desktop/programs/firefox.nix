{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs' }:
    { config, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        programs.firefox = {
          enable = true;
          package = inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
          policies = {
            ExtensionSettings = {
              "*".installation_mode = "blocked";
              "uBlock0@raymondhill.net" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                installation_mode = "force_installed";
              };
              "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
                installation_mode = "force_installed";
              };

            };
          };

        };
      };
    }
  );
}
