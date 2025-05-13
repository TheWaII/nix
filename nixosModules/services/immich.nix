{ pkgs, lib, config, ... }: {

  options = { immich.enable = lib.mkEnableOption "enables immich"; };

  config = lib.mkIf config.immich.enable {
    services.immich = {
      enable = true;
      port = 2283;
    };
    environment.systemPackages = with pkgs; [ immich immich-cli ];
  };
}
