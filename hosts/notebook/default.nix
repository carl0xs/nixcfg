{ config, pkgs, extraHostsFromEnv, inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "hm-bak";
    users.carlos = import ../../home/notebook/default.nix;
  };

  imports = [

    # Common modules
    ../../modules/common/default.nix
    ../../modules/common/locale.nix
    ../../modules/common/users.nix
    ../../modules/common/ssh.nix

    # Workstation modules
    ./desktop.nix
    ./i3

    # The old top-level modules directory
    # is now replaced by the new structure.
    # We no longer import ./modules
  ];

  # Override common hostname for this specific host
  networking.hostName = "notebook";

  virtualisation.docker.enable = true;
}
