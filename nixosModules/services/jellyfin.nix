{ pkgs, lib, config, ... }: {

  options = { jellyfin.enable = lib.mkEnableOption "enables jellyfin"; };

  config = lib.mkIf config.jellyfin.enable {
    services.jellyfin = {
      enable = true; #runs on port 8096
    };
    environment.systemPackages = with pkgs; [ jellyfin ];
  };
}
