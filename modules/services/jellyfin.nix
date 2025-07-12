{ pkgs, lib, config, ... }: {

  options = { jellyfin.enable = lib.mkEnableOption "enables jellyfin"; };

  config = lib.mkIf config.jellyfin.enable {
    services.jellyfin = {
      enable = true; # runs on port 8096
      openFirewall = true;
      user = "servewall";
    };
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}