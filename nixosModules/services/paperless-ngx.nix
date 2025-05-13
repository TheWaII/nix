{ pkgs, lib, config, ... }: {

  options = {
    paperless-ngx.enable = lib.mkEnableOption "enables paperless-ngx";
  };

  config = lib.mkIf config.paperless-ngx.enable {
    environment.systemPackages = with pkgs; [ paperless-ngx ];
  };
}
