{ pkgs, lib, config, ... }: {

  options = { sonarr.enable = lib.mkEnableOption "enables sonarr"; };

  config = lib.mkIf config.sonarr.enable {

    users.users.sonarr = {
      isSystemUser = true;
      description = "sonarr user";
      group = "sonarr";
      extraGroups = [ "media" ];
    };

    networking.firewall.allowedTCPPorts = [ 7878 ];

    services.sonarr = { enable = true; };
    environment.systemPackages = with pkgs; [ sonarr ];
  };
}
