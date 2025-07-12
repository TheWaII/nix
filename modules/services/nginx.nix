{ pkgs, lib, config, ... }: {

  options = { nginx.enable = lib.mkEnableOption "enables nginx"; };

  config = lib.mkIf config.nginx.enable {
    services.nginx = {
      enable = true;

      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      
      appendHttpConfig = ''
      limit_req_zone $binary_remote_addr zone=jellyfin_limit:10m rate=30r/s;
      limit_conn_zone $binary_remote_addr zone=addr:10m;
      '';

      virtualHosts."jellyfin.dhawal.eu" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        # Forward traffic to your Jellyfin instance's local address and port
        proxyPass = "http://127.0.0.1:8096";

        # Jellyfin uses WebSockets extensively, so this is crucial!
        proxyWebsockets = true;

         extraConfig = ''
         limit_req zone=jellyfin_limit burst=50 delay=20;
         limit_conn addr 100;
         add_header X-Frame-Options SAMEORIGIN;
         add_header X-Content-Type-Options nosniff;
         add_header X-XSS-Protection "1; mode=block";
         '';
      };
      };
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = "23299221+TheWaII@users.noreply.github.com";
    };
  };
}