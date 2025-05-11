{ self, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      packages.emacs = pkgs.callPackage (
        {
          symlinkJoin,
          emacsWithPackagesFromUsePackage,
          makeWrapper,
          ...
        }:
        let
          initDir = "${self}/emacs"; # must contain init.el and early-init.el
          pkg = emacsWithPackagesFromUsePackage {
            config = "";
            package = pkgs.emacs-igc-pgtk;
            defaultInitFile = false;
            extraEmacsPackages =
              epkgs: with epkgs; [
                use-package
                magit # example
                vertico # another example
                rainbow-delimiters
              ];
          };
        in
        symlinkJoin {
          inherit (pkg) name meta passthru;
          paths = [ pkg ];
          nativeBuildInputs = [ makeWrapper ];
          postBuild = ''
            for f in $out/bin/emacs $out/bin/emacs-*; do
              wrapProgram $f --add-flags "--init-directory ${initDir}"
            done

            rm -rf $out/share/applications
            mkdir -p $out/share/applications
            cp ${pkg}/share/applications/emacs.desktop $out/share/applications
            sed -i -E "s#Exec=emacs([[:space:]]*)#Exec=$out/bin/emacs\\1#g" \
              $out/share/applications/emacs.desktop
          '';
        }
      ) { };
    };
}
