{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        name = "m5gfx";
      in
      {
        inherit name;
        packages.default = pkgs.stdenv.mkDerivation (finalAttrs: {
          pname = name;
          version = "0.1.12";
          src = pkgs.fetchurl {
            url = "https://github.com/m5stack/M5GFX/archive/refs/tags/${finalAttrs.version}.tar.gz";
            hash = "sha256-TRlDglyB4SXc2uQBR7i0EKEvCV7NswrhblskUJIp5BU=";
          };
          installPhase = ''
            mkdir -p $out/include
            cp -r src/* $out/include
          '';
        });
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
