{
  pkgs,
  lib,
  config,
  ...
}: let
  doomDir = "${config.home.homeDirectory}/.config/emacs";
  logDir = "${config.home.homeDirectory}/.cache/emacs";
  logFile = "${logDir}/doomemacs-install.log";
in {
  options = {
    emacs = {
      enable = lib.mkEnableOption "enables emacs";
      doom.enable = lib.mkEnableOption "enables doom emacs";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.emacs.enable {
      programs.emacs = {
        enable = true;
        package = pkgs.emacs30;
      };
      home.packages = with pkgs; [
        git
        ripgrep
        fd
      ];
    })

    (lib.mkIf config.emacs.doom.enable {
      home.file.".config/emacs".enable = false;

      home.activation.cloneDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir -p "${logDir}"
        export PATH="${pkgs.git}/bin:$PATH"
        if [ ! -d "${doomDir}" ]; then
          echo "Cloning Doom Emacs..." | tee -a "${logFile}"
          if ! git clone --depth 1 https://github.com/doomemacs/doomemacs "${doomDir}" &>> "${logFile}"; then
            echo "❌ Failed to clone Doom Emacs. See ${logFile}" | tee -a "${logFile}"
            exit 1
          fi
        fi
      '';

      home.activation.installDoomEmacs = lib.hm.dag.entryAfter ["cloneDoomEmacs"] ''
        if [ -x "${doomDir}/bin/doom" ]; then
          echo "Installing Doom Emacs..." | tee -a "${logFile}"
          export PATH="${pkgs.emacs30}/bin:${pkgs.git}/bin:$PATH"
          if ! "${doomDir}/bin/doom" install --force &>> "${logFile}"; then
            echo "❌ Doom install failed. See ${logFile}" | tee -a "${logFile}"
            exit 1
          fi
        else
          echo "❌ Doom Emacs bin not found at ${doomDir}/bin/doom" | tee -a "${logFile}"
          exit 1
        fi
      '';
    })
  ];
}
