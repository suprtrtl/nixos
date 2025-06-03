{
  pkgs,
  lib,
  config,
  ...
}: let
  doomDir = "${config.home.homeDirectory}/.config/emacs";
  logFile = "./../../logs/emacs/doom-build.log";
in {
  options = {
    emacs = {
      enable = lib.mkEnableOption "enables emacs";
      doom.enable = lib.mkEnableOption "enables doom emacs";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.emacs.enable {
      programs.emacs.enable = true;
      home.packages = with pkgs; [
        git
        ripgrep
        fd
      ];
    })

    (lib.mkIf config.emacs.doom.enable {
      home.file.".config/emacs".source = null;

      home.activation.cloneDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
            if [ ! -d "${doomDir}" ]; then
              echo "Cloning Doom Emacs..."
              git clone --depth 1 https://github.com/doomemacs/doomemacs ${doomDir} &> ${logFile}
        fi
      '';

      home.activation.installDoomEmacs = lib.hm.dag.entryAfter ["cloneDoomEmacs"] ''
        if [ -x ${doomDir}/bin/doom ]; then
          echo "Installing Doom Emacs..."
          ${doomDir}/bin/doom install --force
          fi
      '';
    })
  ];
}
