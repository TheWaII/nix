{ pkgs, lib, config, ... }: {

  options = { radarr.enable = lib.mkEnableOption "enables radarr"; };

  config = lib.mkIf config.radarr.enable {

    users.users.radarr = {
      isSystemUser = true;
      description = "radarr user";
      group = "radarr";
      extraGroups = [ "media" ];
    };

    networking.firewall.allowedTCPPorts = [ 8989 ];

    services.radarr = { enable = true; };
    environment.systemPackages = with pkgs; [ radarr ];
  };
}
