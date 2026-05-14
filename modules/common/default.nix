{ lib, pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./ssh.nix
    ./users.nix
  ];

  # Bootloader
  # Defaults for UEFI machines; hosts can override (e.g., legacy BIOS).
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  # Networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Sao_Paulo";

  environment.systemPackages = with pkgs; [
    wget
    git
    unzip
    gzip
    vim
    cmake
  ];

	nixpkgs.config.allowUnfree = true;

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};

  system.stateVersion = "25.05";
}
