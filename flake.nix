{
  description = "Rust Development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };

      programmer = pkgs.python3Packages.buildPythonPackage rec {
        name = "programmer";
        version = "0.1";
        src = ./.;

        pyproject = true;
        build-system = [
          pkgs.python3Packages.setuptools
        ];

        dependencies = [
          pkgs.python3Packages.pyserial
          pkgs.python3Packages.xmodem
        ];
      };
    in {
      devShells.default = pkgs.mkShell {
        inputsFrom = [
          programmer
        ];
      };

      packages.default = programmer;

      apps.default = {
        type = "app";
        program = "${programmer}/bin/programmer.py";
      };
    }
  );
}
