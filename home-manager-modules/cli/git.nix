{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "suprtrtl";
    userEmail = "owen.rodway@gmail.com";

    extraConfig = {
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
