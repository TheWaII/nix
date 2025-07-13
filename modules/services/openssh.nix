{ pkgs, lib, config, ... }: {

  options = {
    openssh.enable = lib.mkEnableOption "Enable OpenSSH server";
  };

  config = lib.mkIf config.openssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        AuthorizedKeysFile = "%h/.ssh/authorized_keys";
        PasswordAuthentication = false;
        AllowUsers = null; 
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };

    networking.firewall.allowedTCPPorts = [ 22 ];
  };
}