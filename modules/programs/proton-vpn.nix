{ pkgs, lib, config, ... }: {

  options = { proton.enable = lib.mkEnableOption "enables proton"; };

  config = lib.mkIf config.proton.enable {
    environment.systemPackages = with pkgs; [ protonvpn-gui ];
  };
}
