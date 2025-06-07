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
      vaults = {
        "test-vault" = {
          enable = true;
          target = "vault/test-vault";
        };
      };
    };
  };
}
