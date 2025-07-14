{ pkgs, lib, config, ... }: {

  options = { prowlarr.enable = lib.mkEnableOption "enables prowlarr"; };

  config = lib.mkIf config.prowlarr.enable {
    services.prowlarr = { enable = true; };
    environment.systemPackages = with pkgs; [ prowlarr ];
  };
}
