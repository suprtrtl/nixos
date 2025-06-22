{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    obsidian.enable = lib.mkEnableOption "enables obsidian";
  };

  config = lib.mkIf config.obsidian.enable {
    programs.obsidian = {
      enable = true;

      defaultSettings = {
        corePlugins = [
          "backlink"
          "bookmarks"
          "canvas"
          "command-palette"
          "daily-notes"
          "editor-status"
          "file-explorer"
          "global-search"
          "graph"
          "note-composer"
          "outgoing-link"
          "outline"
          "page-preview"
          "slides"
          "switcher"
          "tag-pane"
          "templates"
          "word-count"
        ];
      };

      vaults = {
        "test-vault" = {
          enable = true;
          target = "vaults/test-vault";
        };
      };
    };
  };
}
