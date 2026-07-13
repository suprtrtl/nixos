{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user.email = "owen.rodway@gmail.com";
      user.name = "suprtrtl";

      init.defaultBranch = "main";

      credential = {
        helper = "manager";
        "https://codeberg.org".username = "suprtrtl";
        "https://codeberg.org".provider = "generic";
        credentialStore = "cache";
      };
    };
  };

  home.packages = with pkgs; [git-credential-manager];
}
