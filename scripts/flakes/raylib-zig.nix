{
  description = "Raylib development environment";

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
      };
    in
      pkgs.mkShell {
        packages = [
          zig-overlay.packages.${system}."0.15.1"

          pkgs.libGL

          # X11 dependencies
          pkgs.xorg.libX11
          pkgs.xorg.libX11.dev
          pkgs.xorg.libXcursor
          pkgs.xorg.libXi
          pkgs.xorg.libXinerama
          pkgs.xorg.libXrandr

          # Uncomment the line below if you want to build Raylib with web support
          pkgs.emscripten
        ];

        # Audio dependencies
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [pkgs.alsa-lib];
      };
  };
}
