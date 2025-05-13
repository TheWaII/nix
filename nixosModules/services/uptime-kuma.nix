{ pkgs, lib, config, ... }: {

  options = { uptime-kuma.enable = lib.mkEnableOption "enables uptime-kuma"; };

  config = lib.mkIf config.uptime-kuma.enable {
    services.uptime-kuma = { enable = true; };
    environment.systemPackages = with pkgs; [ uptime-kuma ];
  };
}
