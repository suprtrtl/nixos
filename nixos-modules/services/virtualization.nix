{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    virt-manager.enable = lib.mkEnableOption "enable qemukvm through virt-manager";
  };

  config = lib.mkIf config.virt-manager.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
