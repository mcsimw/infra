{ config, lib, ... }:
{
  _module.args.wrappers = (import config.sources.wrappers { pkgs = { inherit lib; }; }).lib;
}
