{ pkgs, lib, config, ... }: {

  options = { steam.enable = lib.mkEnableOption "enables steam"; };

  config = lib.mkIf config.steam.enable {
    environment.systemPackages = [ pkgs.steam ];
  };
}
