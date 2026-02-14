{
  description = "zig cookbook shell environment";

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
    system = "x86_64-linux"; # Change to your system, e.g., "aarch64-darwin" or "x86_64-darwin"
  in {
    devShells.${system}.default = let
      pkgs = import nixpkgs {inherit system;};
    in
      pkgs.mkShell {
        packages = [
          zig-overlay.packages.${system}."0.15.2"
        ];
        shellHook = ''
          echo Launching Cookbook
          zig build run-all
        '';
      };
  };
}
