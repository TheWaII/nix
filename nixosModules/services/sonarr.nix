{ pkgs, lib, config, ... }: {

  options = { sonarr.enable = lib.mkEnableOption "enables sonarr"; };

  config = lib.mkIf config.sonarr.enable {
    services.sonarr = { enable = true; };
    environment.systemPackages = with pkgs; [ sonarr ];
  };
}