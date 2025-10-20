# Mostly stolen from iynaix
{
  perSystem =
    {
      pkgs,
      lib,
      system,
      ...
    }:
    let
      platforms = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      isSupported = builtins.elem system platforms;
    in
    lib.mkIf isSupported (
      let
        sources = pkgs.callPackage ./_sources/generated.nix { };

        source =
          {
            "x86_64-linux" = sources.helium-x86_64;
            "aarch64-linux" = sources.helium-aarch64;
          }
          .${system};

        pname = "helium";
        appimageContents = pkgs.appimageTools.extract source;
      in
      {
        packages.helium = pkgs.appimageTools.wrapType2 (
          source
          // {
            inherit pname;
            nativeBuildInputs = [ pkgs.makeWrapper ];
            extraInstallCommands = ''
              wrapProgram $out/bin/${pname} \
                  --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"
              install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
              substituteInPlace $out/share/applications/${pname}.desktop \
                --replace-fail 'Exec=AppRun' 'Exec=${pname}'
              cp -r ${appimageContents}/usr/share/icons $out/share
            '';
            extraBwrapArgs = [
              "--ro-bind-try /etc/chromium/policies/managed/default.json /etc/chromium/policies/managed/default.json"
              "--ro-bind-try /etc/xdg/ /etc/xdg/"
            ];
            meta = {
              description = "Private, fast, and honest web browser";
              homepage = "https://helium.computer/";
              maintainers = [ lib.maintainers.mcsimw ];
              inherit platforms;
            };
          }
        );
      }
    );
}
