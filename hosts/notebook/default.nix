{ config, pkgs, ... }:

{
  imports = [

    # Common modules
    ../../modules/common/base.nix
    ../../modules/common/locale.nix
    ../../modules/common/users.nix
    ../../modules/common/ssh.nix

    # Workstation modules
    ../../modules/workstation/desktop.nix
    ../../modules/workstation/devtools.nix
    ../../modules/workstation/i3

    # The old top-level modules directory
    # is now replaced by the new structure.
    # We no longer import ./modules
  ];

  # Override common hostname for this specific host
  networking.hostName = "notebook";

  virtualisation.docker.enable = true;
}
