{ config, pkgs, extraHostsFromEnv, inputs, ... }:

{
  imports = [
    # Common modules
    ../../common/default.nix

    # Workstation modules
    ./desktop.nix
  ];

  networking.hostName = "workstation";

  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; pkgs = pkgs; };
    backupFileExtension = "hm-bak";
    sharedModules = [
      inputs.niri.homeModules.niri
      inputs.nixvim.homeManagerModules.nixvim
    ];
    users.carlos = import ./home.nix;
  };

}
