{ description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    phps.url = "github:loophp/nix-shell";
  };

  outputs = { self, nixpkgs, flake-utils, phps }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ phps.overlays.default ];
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
          ];
        };

        # Define the packages attribute
        packages.x86_64-linux.default = pkgs.mkDerivation {
          name = "my-package";
          builder = builtins.toFile "builder.sh" ''
            echo "Hello, World!"
          '';
          args = {
            inherit system;
          };
        };
      });
}
