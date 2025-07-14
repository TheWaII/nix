{ pkgs, lib, config, ... }: {

  options = { jellyfin.enable = lib.mkEnableOption "enables jellyfin"; };

  config = lib.mkIf config.jellyfin.enable {

    #user for jellyfin
    users.users.jellyfin = {
      isSystemUser = true;
      description = "jellyfin user";
      group = "jellyfin";
      extraGroups = [ "render" "video" "media" ];
    };

    services.jellyfin = {
      enable = true; # runs on port 8096
      openFirewall = true;
      user = "jellyfin";
    };
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];

    nixpkgs.overlays = with pkgs;
      [
        (final: prev: {
          jellyfin-web = prev.jellyfin-web.overrideAttrs
            (finalAttrs: previousAttrs: {
              installPhase = ''
                runHook preInstall

                # this is the important line
                sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

                mkdir -p $out/share
                cp -a dist $out/share/jellyfin-web

                runHook postInstall
              '';
            });
        })
      ];
  };
}
