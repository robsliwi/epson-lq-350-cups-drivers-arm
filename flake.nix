{
  description = "EPSON LQ-350 Drivers for CUPS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "armv6l-linux"
          "armv7l-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ]
          (system:
            function (import nixpkgs {
              inherit system;
            }));
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.stdenv.mkDerivation {
          name = "Epson_LQ-350_CUPS_driver_for_ARMv6";
          src = pkgs.fetchzip {
            url = "https://download.epson-europe.com/pub/download/6337/epson633749eu.zip";
            hash = "sha256-O0IZ235UEJLoRXKYmtwC967vJ9XwUZIitZf0PEWkA0c=";
          };

          nativeBuildInputs = with pkgs; [ cups ];
          buildPhase = ''
            mkdir -p $out
            cd ./src
            tar -zxvf epsidm24-secc0004-1.0.0.tar.gz -C /tmp
            cd /tmp/epsidm24-secc0004-1.0.0
            sh configure
            make
          '';

          installPhase = ''
            mkdir -p $out
            cp -r /tmp/epsidm24-secc0004-1.0.0/ppd/eplq350-rastertoepsidm24-secc0004.ppd $out
            cp -r /tmp/epsidm24-secc0004-1.0.0/src/rastertoepsidm24-secc0004 $out
          '';
        };
      });
    };
}
