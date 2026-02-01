{
  description = "NixOS configuration Carl0xs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      specialArgs = {
        inherit inputs;
        extraHostsFromEnv = builtins.getEnv "EXTRA_HOSTS";
      };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosConfigurations = {
        notebook = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/notebook/default.nix
            ./hosts/notebook/hardware-configuration.nix
          ];
        };

        homeserver = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/homeserver/default.nix
            ./hosts/homeserver/hardware-configuration.nix
          ];
        };
      };
    };
}
