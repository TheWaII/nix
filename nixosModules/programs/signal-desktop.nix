{ pkgs, lib, config, ... }: {

  options = { signal-desktop.enable = lib.mkEnableOption "enables signal messanging desktop app"; };

  config = lib.mkIf config.signal-desktop.enable {
    environment.systemPackages = with pkgs; [ signal-desktop ];
  };
}
