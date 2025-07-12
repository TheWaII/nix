 { pkgs, lib, config, ... }: {

  options = { brave.enable = lib.mkEnableOption "enables brave"; };
 environment.systemPackages = [
    pkgs.protonvpn-gui
  ];
  }
