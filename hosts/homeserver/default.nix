{ config, pkgs, ... }:

{
  imports = [

    # Common modules
    ../../modules/common/base.nix
    ../../modules/common/locale.nix
    ../../modules/common/users.nix
    ../../modules/common/ssh.nix

    # Server modules
    ../../modules/server/docker.nix
    ../../modules/server/firewall.nix
  ];

  # Override common hostname for this specific host
  networking.hostName = "homeserver";
}
