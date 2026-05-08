{ config, pkgs, ... }:

{
  imports = [
    ./services/docker.nix
    ./services/fireall.nix
    ./services/tailscale.nix

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
  networking.firewall.allowedTCPPorts = [ ];

  virtualisation.docker.enable = true;

  services.pihole.enable = true;
}
