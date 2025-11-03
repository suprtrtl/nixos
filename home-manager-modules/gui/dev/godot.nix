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
      godot-mono
    ];
  };
}
