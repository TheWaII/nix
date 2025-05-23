{ pkgs, lib, config, ... }: {

  options = { discord.enable = lib.mkEnableOption "enables discord"; };

  config = lib.mkIf config.discord.enable {
    environment.systemPackages = with pkgs; [ discord ];
  };
}
