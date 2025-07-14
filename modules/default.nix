{ lib, ... }: # Standard module arguments
{
  imports = [
    #programs
    ./programs/brave.nix
    #./programs/discord.nix
    ./programs/proton-vpn.nix
    #./programs/spotify.nix
    #./programs/signal-desktop.nix
    #./programs/steam.nix
    ./programs/vscode.nix
    ./programs/qbittorrent.nix

    #services
    ./services/arr/bazarr.nix
    ./services/arr/prowlarr.nix
    ./services/arr/radarr.nix
    ./services/arr/sonarr.nix
    ./services/git.nix
    ./services/nginx.nix
    # ./services/homepage-dashboard.nix
    #./services/immich.nix
    ./services/jellyfin.nix
    #./services/paperless-ngx.nix
    ./services/openssh.nix
    #./services/uptime-kuma.nix

  ];

  #############################################
  # programs                                  #
  #############################################

  brave.enable = lib.mkDefault true;
  vscode.enable = lib.mkDefault true;

  #############################################
  # services                                  #
  #############################################

  #arr
  bazarr.enable = lib.mkDefault true;
  # prowlarr.enable = lib.mkDefault true;
  radarr.enable = lib.mkDefault true;
  # sonarr.enable = lib.mkDefault true;

  #the rest
  jellyfin.enable = lib.mkDefault true;
  nginx.enable = lib.mkDefault true;
  openssh.enable = lib.mkDefault true;
  proton.enable = lib.mkDefault true;
  qbittorrent.enable = lib.mkDefault true;

}
