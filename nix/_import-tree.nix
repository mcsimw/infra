{ sources, ... }:
{
  imports = [ (import "${sources.import-tree}" ./.) ];
}
