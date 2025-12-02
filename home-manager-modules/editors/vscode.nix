{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    vscode.enable =
      lib.mkEnableOption "enable vscode";
  };

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        emroussel.atomize-atom-one-dark-theme
        vscodevim.vim

        # Languages

        # Nix
        jnoortheen.nix-ide

        # rust
        rust-lang.rust-analyzer

        # Java
        vscjava.vscode-java-pack
        redhat.java
        vscjava.vscode-maven
        vscjava.vscode-java-test
        vscjava.vscode-java-pack
        vscjava.vscode-java-dependency
        vscjava.vscode-java-debug
        vscjava.vscode-gradle
      ];
    };

    home.packages = with pkgs; [
      wl-clipboard
      ripgrep
      jdk25
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
