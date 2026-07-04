{
  lib,
  config,
  ...
}: {
  options = {
    ollama.enable = lib.mkEnableOption "enable ollama";
  };

  config = lib.mkIf config.ollama.enable {
    services.ollama = {
      enable = true;
    };
  };
}
