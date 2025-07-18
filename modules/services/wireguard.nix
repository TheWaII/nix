{ pkgs, lib, config, ... }:

{
  options = {
    wireguard.enable = lib.mkEnableOption "Enable WireGuard";
  };

  config = lib.mkIf config.wireguard.enable {
    environment.systemPackages = with pkgs; [
      wireguard-tools
      iproute2
      iptables
    ];

    networking.wg-quick.interfaces = {
      wg0 = {
        address = [ "10.2.0.2/32" ];
        dns = [ "10.2.0.1" ];
        listenPort = 51820;
        privateKeyFile = "/home/servewall/wireguard-keys/privatekey";
        peers = [{
          publicKey = "zJ9EtguoeooUHMQa9G4GSBjCV+x+mGsBTbqPHNrzrFo=";
          allowedIPs = [ "0.0.0.0/0" ]; # Full tunnel
          endpoint = "91.132.139.2:51820";
          persistentKeepalive = 25;
        }];
      };
    };

    #idk why it works, but it works (vibe coded)
    systemd.services.fix-web-routing = {
      description = "Route web traffic replies via LAN gateway (enp7s0)";
      wantedBy = [ "network-online.target" ];
      after = [ "network-online.target" "wg-quick-wg0.service" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = pkgs.writeShellScript "fix-web-routing" ''
          set -eux

          # Flush old rules (avoid duplicates)
          ${pkgs.iptables}/bin/iptables -t mangle -D PREROUTING -p tcp -m multiport --dports 80,443 -j MARK --set-mark 10 || true
          ${pkgs.iptables}/bin/iptables -t mangle -D OUTPUT -p tcp -m multiport --sports 80,443 -j MARK --set-mark 10 || true

          # Mark incoming TCP traffic on ports 80 and 443 for routing
          ${pkgs.iptables}/bin/iptables -t mangle -A PREROUTING -p tcp -m multiport --dports 80,443 -j MARK --set-mark 10

          # Also mark outgoing replies on ports 80 and 443 so replies get marked too
          ${pkgs.iptables}/bin/iptables -t mangle -A OUTPUT -p tcp -m multiport --sports 80,443 -j MARK --set-mark 10

          # Add routing table 200 to route marked packets via LAN gateway
          ${pkgs.iproute2}/bin/ip route add default via 192.168.178.1 dev enp7s0 table 200 || true

          # Add ip rule to use routing table 200 for marked packets
          ${pkgs.iproute2}/bin/ip rule add fwmark 10 table 200 priority 100 || true
        '';
      };
    };
  };
}
