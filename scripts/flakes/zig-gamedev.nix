{
  description = "zig-gamedev development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    zig-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    zig-overlay,
    ...
  }: let
    system = "x86_64-linux"; # please change it based on your system details
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      pkgs.mkShell {
        packages = [
          zig-overlay.packages.${system}."0.15.1"

          pkgs.libGL

          # X11 dependencies
          pkgs.libX11
          pkgs.libXcursor
          pkgs.libXi
          pkgs.libXinerama
          pkgs.libXrandr

          pkgs.emscripten
          pkgs.dawn
        ];

        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.libGL
          pkgs.libX11
          pkgs.libXcursor
          pkgs.libXi
          pkgs.libXinerama
          pkgs.libXrandr
          pkgs.alsa-lib
          pkgs.dawn
        ];

        NIX_LDFLAGS = toString [
          "-L${pkgs.dawn}/lib"
          "-L${pkgs.libGL}/lib"
          "-L${pkgs.libX11}/lib"
        ];
      };
  };
}
