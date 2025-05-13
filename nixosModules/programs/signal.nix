{ pkgs, lib, config, ... }: {

  options = { signal.enable = lib.mkEnableOption "enables signal"; };

  config = lib.mkIf config.signal.enable {
    environment.systemPackages = with pkgs; [ signal-desktop ];
  };
}
