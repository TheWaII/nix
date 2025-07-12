{ lib, ... }: # Standard module arguments
{
  imports = [
    #programs
    ./programs/brave.nix
    #./programs/discord.nix
    #./programs/spotify.nix
    #./programs/signal-desktop.nix
    #./programs/steam.nix
    ./programs/vscode.nix
    #./programs/qbittorrent.nix

    #services
    #./services/bazarr.nix
    ./services/git.nix
    # ./services/homepage-dashboard.nix
    #./services/immich.nix
    ./services/jellyfin.nix
    #./services/paperless-ngx.nix
    #./services/radarr.nix
    #./services/sonarr.nix
    #./services/uptime-kuma.nix
  ];

  #programs
  brave.enable = lib.mkDefault true;
  vscode.enable = lib.mkDefault true;

  #services
  #git.enable = lib.mkDefault true;

}
