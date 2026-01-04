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
        "https://github.com".username = "suprtrtl";
        credentialStore = "cache";
      };
    };
  };

  home.packages = with pkgs; [git-credential-manager];
}
