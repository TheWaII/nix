{ pkgs, lib, config, ... }: {

  options = {
    homepage-dashboard.enable = lib.mkEnableOption "enables homepage-dashboard";
  };

  config = lib.mkIf config.homepage-dashboard.enable {
    services.homepage-dashboard = { enable = true; };
    environment.systemPackages = with pkgs; [ homepage-dashboard ];
  };
}
