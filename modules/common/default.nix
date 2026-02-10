{ config, lib, pkgs, ... }:

{
  # Bootloader
  # Defaults for UEFI machines; hosts can override (e.g., legacy BIOS).
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  # Networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Sao_Paulo";

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    unzip
    gzip
    vim
    cmake
  ];

  system.stateVersion = "25.05";
}
