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
            alignment = "left";
            segments = [
              {
                foreground = "cyan";
                style = "powerline";
                template = "{{ if .WSL }}WSL at {{ end }}{{.Icon}}";
                type = "os";
              }
              {
                foreground = "cyan";
                properties = {
                  style = "full";
                };
                style = "plain";
                template = " {{ .Path }} ";
                type = "path";
              }
              {
                foreground = "red";
                properties = {
                  fetch_status = true;
                };
                style = "plain";
                template = ":: {{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Staging.Changed }}  {{ .Staging.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Working.Changed }}  {{ .Working.String }}{{ end }} ";
                type = "git";
              }
            ];
            type = "prompt";
          }
          {
            alignment = "right";
            segments = [
              {
                foreground = "red";
                style = "plain";
                template = "| root ";
                type = "root";
              }
              {
                foreground = "blue";
                style = "powerline";
                template = "|  {{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }} ";
                type = "dart";
              }
              {
                foreground = "green";
                style = "powerline";
                template = "|  {{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }} ";
                type = "node";
              }
              {
                foreground = "yellow";
                properties = {
                  display_mode = "context";
                  fetch_virtual_env = true;
                };
                style = "plain";
                template = "|  {{ .Venv }} ";
                type = "python";
              }
              {
                type = "nix-shell";
                style = "powerline";
                foreground = "blue";
                background = "transparent";
                template = "| 󱄅 {{ .Type }} ";
              }
              {
                foreground_templates = [
                  "{{if eq \"Charging\" .State.String}}<yellow>{{end}}"
                  "{{if eq \"Discharging\" .State.String}}<red>{{end}}"
                  "{{if eq \"Full\" .State.String}}<green>{{end}}"
                ];
                invert_powerline = true;
                properties = {
                  charged_icon = "󰁹 ";
                  charging_icon = "󰂄 ";
                };
                style = "powerline";
                template = "| {{ if not .Error }}{{ .Icon }}{{ .Percentage }}{{ end }}{{ .Error }}  ";
                type = "battery";
              }
              {
                foreground = "lightGreen";
                style = "plain";
                template = "| {{ .CurrentDate | date .Format }} ";
                type = "time";
              }
            ];
            type = "prompt";
          }
          {
            alignment = "left";
            newline = true;
            segments = [
              {
                foreground = "lightGreen";
                foreground_templates = [
                  "{{ if gt .Code 0 }}red{{ end }}"
                ];
                properties = {
                  always_enabled = true;
                };
                style = "powerline";
                template = " 󱞩 ";
                type = "status";
              }
            ];
            type = "prompt";
          }
        ];

        transient_prompt = {
          background = "transparent";
          foreground = "lightGreen";
          template = " 󱞩 ";
        };

        version = 3;
      };
    };
  };
}
