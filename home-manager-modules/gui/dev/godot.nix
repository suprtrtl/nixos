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
      audacity
      itch
      godot_4_7-mono
      sfxr
    ];
  };
}
