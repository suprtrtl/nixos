{
  description = "Minimal flake for OCaml projects.";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs";
  };
  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs.ocamlPackages) buildDunePackage;
      in {
        packages = {
          default = buildDunePackage {
            pname = "project-name";
            duneVersion = "3";
            version = "0.1";
            installTargets = "all doc";
            src = ./.;
            nativeBuildInputs = with pkgs.ocamlPackages; [
              dune_3
            ];
            preBuild = "export HOME=$TMPDIR";
          };
        };
        devShells = {
          default = pkgs.mkShell {
            name = "Ocaml development shell environment.";
            inputsFrom = [self.packages.${system}.default];
            packages = with pkgs.ocaml-ng.ocamlPackages; [
              ocamlformat
              ocaml-lsp
              utop
              pkgs.gnumake
            ];
            shellHook = ''
              echo "Welcome in the devshell."
            '';
          };
        };
      }
    );
}
