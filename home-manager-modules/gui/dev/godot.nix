{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    godot.enable = lib.mkEnableOption "enable godot";
  };

  config = lib.mkIf config.godot.enable {
    home.packages = with pkgs; [
      aseprite
      audacity
      itch
      godot-mono
      sfxr
    ];
  };
}
