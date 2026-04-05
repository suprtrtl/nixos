{
  description = "An Odin dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "odin-dev-shell";

          packages = [
            pkgs.odin
            pkgs.ols
          ];

          shellHook = ''
            export ODIN_DIR=${pkgs.odin}
                     echo "Welcome to the Odin development environment for ${system}!"
          '';
        };
      }
    );
}
