{
  perSystem =
    { inputs', ... }:
    {
      packages.firefox = inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
    };
}
