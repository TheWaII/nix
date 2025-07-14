{ pkgs, lib, config, ... }: {

  options = { radarr.enable = lib.mkEnableOption "enables radarr"; };

  config = lib.mkIf config.radarr.enable {
    services.radarr = { enable = true; };
    environment.systemPackages = with pkgs; [ radarr ];
  };
}
