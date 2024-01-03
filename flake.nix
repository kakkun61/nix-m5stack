{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        name = "m5stack";
        packages = {
          default = self.packages.${system}.m5stack;
          m5stack = pkgs.stdenv.mkDerivation (finalAttrs: {
            pname = "m5stack";
            version = "0.4.6";
            src = pkgs.fetchurl {
              url = "https://github.com/m5stack/M5Stack/archive/refs/tags/${finalAttrs.version}.tar.gz";
              hash = "sha256-2XnX8r1YXoPuJqwtZMlW610pVVN28FOG9k//o3Y0PPw=";
            };
            installPhase = ''
              mkdir -p $out/include
              cp -r src/* $out/include
            '';
          });
          m5gfx = pkgs.stdenv.mkDerivation (finalAttrs: {
            pname = "m5gfx";
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
          m5unified = pkgs.stdenv.mkDerivation (finalAttrs: {
            pname = "m5unified";
            version = "0.1.12";
            src = pkgs.fetchurl {
              url = "https://github.com/m5stack/M5Unified/archive/refs/tags/${finalAttrs.version}.tar.gz";
              hash = "sha256-xWWrBateGH1sNfCaoNiLCiyH8i2Dlm0dnPTJHC9vNhI=";
            };
            installPhase = ''
              mkdir -p $out/include
              cp -r src/* $out/include
            '';
          });
        };
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
