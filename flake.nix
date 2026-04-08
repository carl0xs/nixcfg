{
  description = "NixOS configuration Carl0xs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, niri, neovim-nightly-overlay }@inputs:
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
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/laptop/default.nix
            ./hosts/laptop/hardware-configuration.nix
            {
              home-manager.sharedModules = [
                niri.homeModules.niri
              ];
            }
          ];
        };

        homelab = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/lab-server/default.nix
            ./hosts/lab-server/hardware-configuration.nix
          ];
        };
      };
    };
}
