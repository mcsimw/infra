{
  flake.modules.nixos.kakoune =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    let
      cfg = config.myShit.programs.kakoune;
    in
    {
      options.myShit.programs.kakoune = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether to enable Kakoune.";
        };
        defaultEditor = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Set Kakoune as the default editor.";
        };
      };

      config = lib.mkIf cfg.enable {
        environment = {
          systemPackages = with pkgs; [
            (kakoune-unwrapped.overrideAttrs {
              version = inputs.kakoune.rev;
              src = inputs.kakoune;
              postPatch = ''
                echo "${inputs.kakoune.rev}" >.version
              '';
            })
          ];
          variables.EDITOR = lib.mkIf cfg.defaultEditor (lib.mkOverride 999 "kak");
        };
      };
    };
}
