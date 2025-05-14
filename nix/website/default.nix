{
  perSystem =
    { pkgs, ... }:
    {
      devShells.website = pkgs.mkShell {
        buildInputs = [
          pkgs.nodejs_24
        ];
      };

    };
}
