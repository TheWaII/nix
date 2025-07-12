{
  description = "Nixos config flake";

  inputs = { nixpkgs = { url = "nixpkgs/nixos-unstable"; }; };

  outputs = { self, nixpkgs, ... }:
    let lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        servewall = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/server/configuration.nix ];
        };
      };
    };
}
