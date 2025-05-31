{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    oh-my-posh.enable = lib.mkEnableOption "enables oh my posh";
  };

  config = lib.mkIf config.oh-my-posh.enable {
    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";

        blocks = [
          {
            segments = [
              {
                foreground = "#007ACC";
                template = " {{ .CurrentDate | date .Format }} ";
                properties = {
                  time_format = "15:04:05";
                };
                style = "plain";
                type = "time";
              }
            ];
            type = "rprompt";
          }
          {
            alignment = "left";
            newline = true;
            segments = [
              {
                background = "yellow";
                foreground = "black";
                leading_diamond = "";
                template = " {{ .UserName }} ";
                style = "diamond";
                trailing_diamond = "";
                type = "session";
              }
              {
                background = "blue";
                foreground = "black";
                powerline_symbol = "";
                template = " {{ .Path }} ";
                properties = {
                  style = "folder";
                };
                exclude_folders = [
                  "/super/secret/project"
                ];
                style = "powerline";
                type = "path";
              }
              {
                background = "magenta";
                template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}";
                properties = {
                  branch_icon = "";
                  commit_icon = "@";
                  fetch_status = true;
                };
                foreground = "transparent";
                style = "powerline";
                powerline_symbol = "";
                type = "git";
              }
            ];
            type = "prompt";
          }
        ];

        transient_prompt = {
          background = "transparent";
          foreground = "white";
          template = ">>";
        };

        secondary_prompt = {
          background = "transparent";
          foreground = "white";
          template = "-> ";
        };

        final_space = true;
        version = 3;
      };
    };
  };
}
