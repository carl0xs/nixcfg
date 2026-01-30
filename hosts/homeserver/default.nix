{ config, pkgs, ... }:

{
  imports = [

    # Common modules
    ../../modules/common/default.nix
    ../../modules/common/locale.nix
    ../../modules/common/users.nix
    ../../modules/common/ssh.nix

    # Server modules
    ../../modules/server/docker.nix
    ../../modules/server/firewall.nix
    ../../modules/server/tailscale.nix
    ../../modules/server/nginx.nix
    ../../modules/server/phoenix-blog.nix
    ../../modules/server/cloudflared.nix
  ];

  # Override common hostname for this specific host
  networking.hostName = "homeserver";

  # Legacy BIOS bootloader (most Dell 1st-gen i5 boxes are BIOS-only)
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
}
