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
        jnoortheen.nix-ide
      ];
    };

    home.packages = with pkgs; [
      wl-clipboard
      ripgrep
    ];

    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
