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

      virtualHosts."_" = {
        listen = [
          {
            addr = "0.0.0.0";
            port = 80;
          }
          {
            addr = "0.0.0.0";
            port = 443;
            ssl = true;
          }
        ];
        extraConfig = ''
          ssl_reject_handshake on; 
          return 444; 
        '';
      };

      virtualHosts."jellyfin.dhawal.eu" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
          proxyWebsockets = true;

          extraConfig = ''
            limit_req zone=jellyfin_limit burst=50 delay=20;
            limit_conn addr 100;
            add_header Cross-Origin-Resource-Policy "cross-origin" always;
            add_header X-Content-Type-Options nosniff;
            add_header X-XSS-Protection "1; mode=block";
            add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
            add_header Referrer-Policy "no-referrer-when-downgrade" always;
            add_header Permissions-Policy "geolocation=(), microphone=()" always;
          '';
        };
      };
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = "23299221+TheWaII@users.noreply.github.com";
    };
    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
