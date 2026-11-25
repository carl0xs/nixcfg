{
  description = "NixOS configuration Carl0xs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    blog.url = "github:carl0xs/blog";
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    purevim = {
      url = "github:carl0xs/purevim";
      flake = false;
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , purevim
    , neovim-nightly-overlay
    , deploy-rs
    , sops-nix
    , blog
    , firefox-addons
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      specialArgs = {
        inherit inputs;
        extraHostsFromEnv = builtins.getEnv "EXTRA_HOSTS";
      };
      hostIp = builtins.getEnv "HOST_IP";
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      deploy.nodes.onering = {
        hostname = hostIp;

        profiles.system = {
          user = "root";

          path =
            deploy-rs.lib.${system}.activate.nixos
              self.nixosConfigurations.onering;
        };
      };

      nixosConfigurations = {
        inherit system;
        cavetroll = nixpkgs.lib.nixosSystem {
          specialArgs = specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/cavetroll/default.nix
            ./hosts/cavetroll/hardware-configuration.nix
          ];
        };

        onering = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = specialArgs;
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/onering/default.nix
            ./hosts/onering/hardware-configuration.nix
          ];
        };
      };
    };
}
