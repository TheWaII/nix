{ pkgs, lib, config, ... }: {

  options = { prowlarr.enable = lib.mkEnableOption "enables prowlarr"; };

  config = lib.mkIf config.prowlarr.enable {

    users.users.prowlarr = {
      isSystemUser = true;
      description = "prowlarr user";
      group = "media";
    };

    services.prowlarr = {
      enable = true;
      # user = "prowlarr" is by default and there is 
      # no option to assign a user (?)

      openFirewall = true; # opens port 9696

    };

    environment.systemPackages = with pkgs; [ prowlarr ];
  };
}
