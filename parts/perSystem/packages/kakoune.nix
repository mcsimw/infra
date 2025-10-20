{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.kakoune = pkgs.kakoune-unwrapped.overrideAttrs {
        version = inputs.kakoune.rev;
        src = inputs.kakoune;
        postPatch = ''
          echo "${inputs.kakoune.rev}" >.version
        '';
      };
    };
}
