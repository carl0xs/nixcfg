{
  description = "NixOS configuration for multiple hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      system = "x86_64-linux";
      specialArgs = {
        inherit rust-overlay;
      };
    in
    {
      nixosConfigurations = {
        notebook = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
          specialArgs = {
            extraHostsFromEnv = builtins.getEnv "EXTRA_HOSTS" "";
          };
          modules = [
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

      devShells.${system}.default =
        let
          overlays = [ (import rust-overlay) ];
          pkgs = import nixpkgs {
            inherit system overlays;
          };
        in
        pkgs.mkShell {
          buildInputs = with pkgs; [
            nixpkgs-fmt
            nodejs_22
          ];
        };
    };
}
