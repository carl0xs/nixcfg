{ pkgs, ... }:

{
  imports = [
    ../../modules/common/default.nix
    ../../modules/desktop/default.nix
    ../../modules/services/tailscale/default.nix
  ];


  users.users.carlos.shell = pkgs.fish;

  virtualisation.docker.enable = true;

  networking = {
    hostName = "workstation";
    extraHosts = builtins.readFile "/etc/nixos/hosts.local";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  nix.settings.trusted-users = [ "root" "carlos" ];

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.5.3"
  ];
}
