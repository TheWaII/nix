# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/default.nix 
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.hostId = "3132b0fd"; # head -c 8 /etc/machine-id

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.servewall = {
    isNormalUser = true;
    description = "servewall";
    extraGroups = [ "networkmanager" "wheel" "render" "video" ];
  };


  #services
  git = {
    enable = true;
    username = "thewall";
    email = "23299221+TheWaII@users.noreply.github.com"; 
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cpuid
    lf
    lm_sensors
    mission-center
    nixd
    nixfmt-classic
    pciutils
    util-linux
    zfs
  ];

  #START ZFS
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.kernelModules = [ "zfs" ];

  # Correct: only list the real pool name(s)
  boot.zfs.extraPools = [ "zraid" ];

  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };
  #END ZFS

  #GPU Drivers
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD"; # Or "i965" if using older driver
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };      # Same here
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver      # ESSENTIAL: Primary VAAPI driver for Arc (iHD)
      intel-compute-runtime   # ESSENTIAL: OpenCL runtime, likely needed for HDR tone mapping
      libva                   # ESSENTIAL: Core VAAPI library
      vpl-gpu-rt              # RECOMMENDED: Modern Intel Video Processing Library
    ];
  };
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
