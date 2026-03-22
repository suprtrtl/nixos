# https://github.com/AdanW7/nix_C_dev_flake
{
  description = "A clean C dev environment for Mac and Linux using flake-utils";

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
          name = "c-dev-shell";

          packages =
            [
              pkgs.clang
              pkgs.clang-tools # adds clangd, clang-format, clang-tidy

              pkgs.lldb
              pkgs.gdb

              pkgs.gnumake
              pkgs.cmake
              pkgs.ninja

              pkgs.pkg-config
              pkgs.bear
              pkgs.cppcheck
              pkgs.universal-ctags
            ]
            ++ (
              if pkgs.stdenv.isLinux
              then [pkgs.valgrind]
              else []
            );

          shellHook = ''
            export CC=clang
            export CXX=clang++
            echo "Welcome to the C/LLVM development environment for ${system}!"
          '';
        };
      }
    );
}
