{
  perSystem =
    { pkgs, ... }:
    {
      packages.ciscoPacketTracer8 = pkgs.ciscoPacketTracer8.override {
        packetTracerSource = pkgs.fetchurl {
          url = "https://archive.org/download/cpt822/CiscoPacketTracer822_amd64_signed.deb";
          sha256 = "bNK4iR35LSyti2/cR0gPwIneCFxPP+leuA1UUKKn9y0=";
        };
      };
    };
}
