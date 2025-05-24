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
    };
  };

  home.packages = with pkgs; [ git-credential-manager ];
}
