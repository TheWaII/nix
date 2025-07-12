{ pkgs, lib, config, ... }: {

  options = {
    git.enable = lib.mkEnableOption "enables git";
    git.username = lib.mkOption {
      type = lib.types.str;
      description = "Git global user.name";
      default = "";
    };
    git.email = lib.mkOption {
      type = lib.types.str;
      description = "Git global user.email";
      default = "";
    };
  };

  config = lib.mkIf config.git.enable {
    environment.systemPackages = with pkgs; [ git ];

    # Only create /etc/gitconfig if both userName and userEmail are set
    environment.etc = lib.mkIf (
      config.git.username != "" && config.git.email != ""
    ) {
      "gitconfig".text = ''
        [user]
            name = ${config.git.username}
            email = ${config.git.email}
      '';
    };
  };
}