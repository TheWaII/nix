# /home/servewall/NIXCONF/nixosModules/default.nix
{ lib, config, pkgs, ... }: # Standard module arguments are important

{
  # PART 1: Define the on/off switches (options) for your features
  options = {
    features = {
      programs = {
        discord = lib.mkEnableOption "Enable the Discord desktop application";
        # You can add more program toggles here later, e.g.:
        # spotify = lib.mkEnableOption "Enable Spotify";
      };
      services = {
        immich = lib.mkEnableOption "Enable the Immich media server";
        # You can add more service toggles here later, e.g.:
        # jellyfin = lib.mkEnableOption "Enable Jellyfin";
      };
    };
  };

  # PART 2: Use the switches to conditionally import the feature modules
  # This 'imports' list tells NixOS which other module files to load based on the options.
  imports = lib.flatten [ # lib.flatten helps if lib.optional returns lists inside a list
    # If 'features.programs.discord.enable' is true, include discord.nix
    (lib.optional config.features.programs.discord.enable ./programs/discord.nix)

    # If 'features.services.immich.enable' is true, include immich.nix
    (lib.optional config.features.services.immich.enable ./services/immich.nix)

    # Add more conditional imports here later for other features, e.g.:
    # (lib.optional config.features.programs.spotify.enable ./programs/spotify.nix)
    # (lib.optional config.features.services.jellyfin.enable ./services/jellyfin.nix)
  ];

  # PART 3: Any configurations that THIS default.nix module itself provides.
  # For a file that only defines options and imports, this might be empty.
  config = {
    # Example: You could set a system-wide variable if this module was active
    # environment.variables.MY_FEATURES_ACTIVE = "true"; # Just an example, not needed for your toggles
  };
}