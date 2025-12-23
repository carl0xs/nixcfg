{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  ];

  system.stateVersion = "25.05";
}
