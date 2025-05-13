{ pkgs, lib, config, ... }: {

  options = { bazarr.enable = lib.mkEnableOption "enables bazarr"; };

  config = lib.mkIf config.bazarr.enable {
    services.bazarr = { enable = true; };
    environment.systemPackages = with pkgs; [ bazarr ];
  };
}
