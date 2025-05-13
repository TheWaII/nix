# /home/servewall/NIXCONF/nixosModules/services/immich.nix
{ pkgs, lib, config, ... }: # Standard module arguments
{
  services.immich.enable = true;

  # The service option might already install the core immich package.
  # Adding pkgs.immich here ensures it's in the system path if needed,
  # or if it's a different variant than what the service pulls in.
  # You might also want pkgs.immich-cli here.
  environment.systemPackages = with pkgs; [
    immich
    immich-cli
  ];
}