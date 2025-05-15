{ pkgs, lib, config, ... }: {

  options = { minecraft-server.enable = lib.mkEnableOption "enables minecraft-server"; };

  config = lib.mkIf config.minecraft-server.enable {
    environment.systemPackages = with pkgs; [ minecraft-server ];
  };
}
