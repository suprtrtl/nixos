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
      # aseprite * use steam to install
      audacity
      itch
      # godot-mono * use steam to install
      sfxr
    ];
  };
}
