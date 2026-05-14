{ config, pkgs, ... }:

{
  imports = [
    ./services/tailscale.nix
    ./services/pi-hole.nix

    ../../common/default.nix
  ];

  # Override common hostname for this specific host
  networking.hostName = "homelab";

  # Legacy BIOS bootloader (most Dell 1st-gen i5 boxes are BIOS-only)
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.firewall.enable = true;

  virtualisation.docker.enable = true;

  services.pihole-ftl = {
    enable = true;
    openFirewallDNS = true;
    openFirewallWebserver = true;
    settings = {
      webserver.port = "80";
      webserver.api = {
        pwhash = "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918";
      };
      misc.readOnly = false;
    };
  };
}
