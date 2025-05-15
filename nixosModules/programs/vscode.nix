{ pkgs, lib, config, ... }: {

  options = { vscode.enable = lib.mkEnableOption "enables vscode"; };

  config = lib.mkIf config.vscode.enable {
    environment.systemPackages = with pkgs; [ vscode ];
  };
}
