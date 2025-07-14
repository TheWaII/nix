{ pkgs, lib, config, ... }: {

  options = {
    git.enable = lib.mkEnableOption "enables git";

    # username and email is only set system-wide
    git.username = lib.mkOption {
      type = lib.types.str;
      description = "Git system user.name";
      default = "";
    };
    git.email = lib.mkOption {
      type = lib.types.str;
      description = "Git system user.email";
      default = "";
    };
  };

  config = lib.mkIf config.git.enable {
    environment.systemPackages = with pkgs; [ git ];

    environment.etc =
      lib.mkIf (config.git.username != "" && config.git.email != "") {
        "gitconfig".text = ''
          [user]
              name = ${config.git.username}
              email = ${config.git.email}
        '';
      };
  };
}
